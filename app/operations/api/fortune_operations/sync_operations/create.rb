# frozen_string_literal: true

require 'xmlsimple'
class Api::FortuneOperations::SyncOperations::Create < ApplicationOperation
  attr_reader :date, :next_date

  def initialize(actor, params)
    super
    @date      = params[:date].to_date.strftime('%Y%m%d')
    @next_date = (@date.to_date + 1.day).strftime('%Y%m%d')
  end

  def call
    ActiveRecord::Base.transaction do
      remove_old_data(date)
      remove_old_data(next_date)
      insert_database(date)
      insert_database(next_date)
    end
  end

  private

  def crawl_data_by_type(type, date)
    data = Faraday.get("https://uranai.zappallas.com/servlet/logic?sid=#{ENV['FORTUNE_ID']}&m=#{type}&date=#{date}").body
    if XmlSimple.xml_in(data)['content']
      XmlSimple.xml_in(data)['content']['explanation']
    else
      raise BadRequestError,
            message: XmlSimple.xml_in(data)['message'][0]
    end
  end

  def insert_database(date)
    Fortune.fortune_types.each do |key, value|
      data = crawl_data_by_type(value, date)
      build_fortune(data, key, date) if data
    end
  end

  def build_fortune(data, type, date) # rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/AbcSize
    arr = []
    obj = {}
    data.each do |item|
      next if item['id'] == 'menu'

      if item['id'].include?('title')
        arr << obj.merge(fortune_type: type, date: date)
        obj = {}
        obj[:title] = item['content']
      elsif item['id'].include?('text')
        obj[:text] = item['content']
      elsif item['id'].include?('rank')
        obj[:rank] = item['content']
      elsif item['id'].include?('sign')
        obj[:sign] = item['content']
      elsif item['id'].include?('color')
        obj[:color] = item['content']
      elsif item['id'].include?('item')
        obj[:item] = item['content']
      elsif item['id'].include?('param')
        obj[:param] = item['content']
      elsif item['id'].include?('image')
        obj[:image] = item['content']
      end

      arr << obj.merge(fortune_type: type, date: date) if item == data.last
    end
    Fortune.import! arr.drop(1)
  end

  def remove_old_data(date)
    Fortune.where(date: date).destroy_all
  end
end

# frozen_string_literal: true

class Api::NewOperations::SyncOperations::Create < ApplicationOperation
  attr_reader :news

  def initialize(actor, params)
    super
    @news = []
  end

  def call
    news_category = NewsCategory.all
    news_api = NewsApiService.new
    news_category.each do |category|
      data = news_api.fetch_by_category(category.code).map do |obj|
        build_news(obj, category.id)
      end
      news << data
    end
    ActiveRecord::Base.transaction do
      NewsFeed.where(title: news.flatten.uniq.pluck(:title)).update_all(deleted_at: Time.zone.now)
      NewsFeed.import! news.flatten.uniq
    end
  end

  def build_news(obj, category_id)
    {
      name:             obj.name,
      published_at:     obj.publishedAt,
      title:            obj.title,
      url:              obj.url,
      url_to_image:     obj.urlToImage,
      author:           obj.author,
      content:          obj.content,
      description:      obj.description,
      news_category_id: category_id,
    }
  end
end

# frozen_string_literal: true

require 'csv'

class Admin::HotelOperations::DownloadOperations::Create < ApplicationOperation
  def call
    generate_csv
  end

  private

  def hotels
    @q = Hotel.ransack(params[:q])
    @q.result.includes(:prefecture, :area_setting, :hotel_category).newest
  end

  def generate_csv
    CSV.generate do |csv|
      csv << I18n.t(:hotels, scope: [:headers])
      hotels.each_with_index do |record, index|
        csv << [index + 1, record.name, record.yomigana, record.prefecture.name,
                record.area_setting.name, record.hotel_category.name, record.contact_info,
                hotel_status(record.status)]
      end
    end
  end
end

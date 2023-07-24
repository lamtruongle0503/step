# frozen_string_literal: true

class Admin::BannerOperations::Create < ApplicationOperation
  def call
    ActiveRecord::Base.transaction do
      banner = create_banner!
      create_banner_prefectures(banner, params[:prefecture_ids])
      upload(banner)
    end
  end

  private

  def create_banner!
    BannerContracts::Create.new(banner_params).valid!
    Banner.create!(banner_params.except(:prefecture_ids))
  end

  def create_banner_prefectures(banner, prefecture_ids)
    prefecture_ids.each do |prefecture_id|
      banner.banner_prefectures.create(prefecture_id: prefecture_id)
    end
  end

  def banner_params
    params.permit(:content, :company_name, :email, :start_date, :end_date, :telephone, :option, :is_show,
                  prefecture_ids: [])
  end

  def upload(banner)
    return unless params[:file].is_a? Array

    params[:file].each do |file|
      upload_multiple_file(banner, file[:url], file[:type], file[:file_type])
    end
  end
end

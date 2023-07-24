# frozen_string_literal: true

class Admin::BannerOperations::Update < ApplicationOperation
  attr_reader :banner

  def initialize(actor, params)
    super
    @banner = Banner.find(params[:id])
  end

  def call
    ActiveRecord::Base.transaction do
      update_banner!(banner)
      update_prefectures(banner, params[:prefecture_ids])
      upload(banner) if params[:file]
    end
  end

  private

  def update_banner!(banner)
    BannerContracts::Update.new(banner_params).valid!
    banner.update!(banner_params.except(:prefecture_ids))
  end

  def update_prefectures(banner, prefecture_ids)
    banner.banner_prefectures.destroy_all

    prefecture_ids.each do |prefecture_id|
      banner.banner_prefectures.create(prefecture_id: prefecture_id)
    end
  end

  def upload(banner)
    return unless params[:file].is_a? Array

    params[:file].each do |file|
      upload_multiple_file(banner, file[:url], file[:type], file[:file_type])
    end
  end

  def banner_params
    params.permit(:content, :start_date, :end_date, :company_name, :email, :telephone, :option, :is_show,
                  prefecture_ids: [])
  end
end

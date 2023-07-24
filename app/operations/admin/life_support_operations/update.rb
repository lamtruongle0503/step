# frozen_string_literal: true

class Admin::LifeSupportOperations::Update < ApplicationOperation
  attr_reader :life_support

  def initialize(actor, params)
    super
    @life_support = LifeSupport.find(params[:id])
  end

  def call
    authorize nil, LifeSupportPolicy

    ActiveRecord::Base.transaction do
      update_life_support!(life_support)
      update_prefectures(life_support, params[:prefecture_ids])
      upload(life_support) if params[:file]
    end
  end

  private

  def update_life_support!(life_support)
    LifeSupportContracts::Update.new(life_support_params).valid!
    life_support.update!(life_support_params.except(:prefecture_ids))
  end

  def update_prefectures(life_support, prefecture_ids)
    life_support.life_support_prefectures.destroy_all

    prefecture_ids.each do |prefecture_id|
      life_support.life_support_prefectures.create(prefecture_id: prefecture_id)
    end
  end

  def upload(life_support)
    return unless params[:file].is_a? Array

    params[:file].each do |file|
      upload_multiple_file(life_support, file[:url], file[:type], file[:file_type])
    end
  end

  def life_support_params
    params.permit(:content, :start_date, :end_date, :company_name, :email, :telephone, :option,
                  prefecture_ids: [])
  end
end

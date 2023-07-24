# frozen_string_literal: true

class Admin::LifeSupportOperations::Create < ApplicationOperation
  def call
    authorize nil, LifeSupportPolicy

    ActiveRecord::Base.transaction do
      life_support = create_life_support!
      create_life_support_prefectures(life_support, params[:prefecture_ids])
      upload(life_support)
    end
  end

  def create_life_support!
    LifeSupportContracts::Create.new(life_support_params).valid!
    LifeSupport.create!(life_support_params.except(:prefecture_ids))
  end

  def create_life_support_prefectures(life_support, prefecture_ids)
    prefecture_ids.each do |prefecture_id|
      life_support.life_support_prefectures.create(prefecture_id: prefecture_id)
    end
  end

  def life_support_params
    params.permit(:content, :company_name, :email, :start_date, :end_date, :telephone, :option,
                  prefecture_ids: [])
  end

  def upload(life_support)
    return unless params[:file].is_a? Array

    params[:file].each do |file|
      upload_multiple_file(life_support, file[:url], file[:type], file[:file_type])
    end
  end
end

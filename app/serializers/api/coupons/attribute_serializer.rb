# frozen_string_literal: true

class Api::Coupons::AttributeSerializer < ApplicationSerializer
  attributes :id, :price, :start_time, :end_time, :publish_date, :image_backgrounds, :pdf_file

  def image_backgrounds
    object.assets.where(type: Asset::IMAGE_BACKGROUNDS).map do |asset|
      Assets::AttributesSerializer.new(asset)
    end
  end

  def pdf_file
    object.assets.where(type: nil).map do |asset|
      Assets::AttributesSerializer.new(asset)
    end
  end
end

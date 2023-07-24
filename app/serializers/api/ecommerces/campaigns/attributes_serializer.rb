# frozen_string_literal: true

class Api::Ecommerces::Campaigns::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :ranking, :description
  has_many :image_backgrounds, serializer: Assets::AttributesSerializer
  has_many :image_details, serializer: Assets::AttributesSerializer

  def image_backgrounds
    object.assets.select { |image| image.type == Asset::IMAGE_BACKGROUNDS }
  end

  def image_details
    object.assets.select { |image| image.type == Asset::IMAGE_DETAILS }
  end
end

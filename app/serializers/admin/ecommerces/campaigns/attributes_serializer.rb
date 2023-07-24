# frozen_string_literal: true

class Admin::Ecommerces::Campaigns::AttributesSerializer < ApplicationSerializer
  attributes :id, :code, :name, :ranking, :description
  has_many :image_backgrounds, serializer: Assets::AttributesSerializer

  def image_backgrounds
    object.assets.select { |image| image.type == Asset::IMAGE_BACKGROUNDS }
  end
end

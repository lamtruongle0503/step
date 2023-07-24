# frozen_string_literal: true

class Api::Ecommerces::Products::MetaSerializer < ApplicationSerializer
  attributes :id, :name, :code, :description, :discount, :colors, :description_info, :tax, :is_discount,
             :avatar, :option_name, :option_color_name

  has_many :image_previews

  def image_previews
    object.assets.select { |image| image.type == Asset::IMAGE_PREVIEWS }
  end

  def avatar
    avatar = object.assets.select { |image| image.type == Asset::PRODUCT_AVATAR }.first
    Assets::AttributesSerializer.new(avatar).as_json if avatar
  end
end

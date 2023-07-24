# frozen_string_literal: true

class Admin::Ecommerces::Orders::Products::MetaSerializer < ApplicationSerializer
  attributes :id, :name, :image_preview, :remaining_count, :is_limit, :tax, :avatar, :option_name,
             :is_delivery_charges, :delivery_charges_fee, :option_color_name

  def image_preview
    object.assets.select { |image| image.type == Asset::IMAGE_PREVIEWS }.first
  end

  def avatar
    avatar = object.assets.select { |image| image.type == Asset::PRODUCT_AVATAR }.first
    Assets::AttributesSerializer.new(avatar).as_json if avatar
  end
end

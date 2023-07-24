# frozen_string_literal: true

class Api::Ecommerces::Campaigns::Products::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :code, :description, :discount, :colors, :description_info, :brand,
             :original_country, :distributor, :precaution, :desired_delivery_date, :hash_tag,
             :product_sizes, :image_details, :image_backgrounds, :is_discount, :tax, :avatar, :option_name,
             :is_delivery_charges, :delivery_charges_fee, :option_color_name

  def colors
    object.colors&.split(', ')
  end

  def image_details
    object.assets.select { |image| image.type == Asset::IMAGE_DETAILS }
  end

  def image_backgrounds
    object.assets.select { |image| image.type == Asset::IMAGE_BACKGROUNDS }
  end

  def avatar
    avatar = object.assets.select { |image| image.type == Asset::PRODUCT_AVATAR }.first
    Assets::AttributesSerializer.new(avatar).as_json if avatar
  end
end

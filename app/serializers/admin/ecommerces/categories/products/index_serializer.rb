# frozen_string_literal: true

class Admin::Ecommerces::Categories::Products::IndexSerializer <
      Admin::Ecommerces::Products::AttributesSerializer
  attributes :avatar, :option_name, :is_delivery_charges, :delivery_charges_fee,
             :option_color_name

  has_many :product_sizes, serializer: Admin::Ecommerces::ProductSizes::AttributesSerializer
  has_many :image_backgrounds, serializer: Assets::AttributesSerializer
  has_many :image_previews, serializer: Assets::AttributesSerializer

  def image_backgrounds
    object.assets.select { |image| image.type == Asset::IMAGE_BACKGROUNDS }
  end

  def image_previews
    object.assets.select { |image| image.type == Asset::IMAGE_PREVIEWS }
  end

  def avatar
    avatar = object.assets.select { |image| image.type == Asset::PRODUCT_AVATAR }.first
    Assets::AttributesSerializer.new(avatar).as_json if avatar
  end
end

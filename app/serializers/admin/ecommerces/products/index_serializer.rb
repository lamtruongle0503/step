# frozen_string_literal: true

class Admin::Ecommerces::Products::IndexSerializer <
      Admin::Ecommerces::Products::AttributesSerializer
  attributes :discount, :avatar, :option_name, :option_color_name

  has_many :assets, serializer: Assets::AttributesSerializer
  has_many :product_sizes, serializer: Admin::Ecommerces::ProductSizes::AttributesSerializer

  def avatar
    avatar = object.assets.select { |image| image.type == Asset::PRODUCT_AVATAR }.first
    Assets::AttributesSerializer.new(avatar).as_json if avatar
  end
end

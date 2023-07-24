# frozen_string_literal: true

class Api::Ecommerces::Products::IndexSerializer < Api::Ecommerces::Products::AttributesSerializer
  attributes :avatar, :option_name, :product_size_price_min, :option_color_name, :point_receive
  has_many :product_sizes, serializer: Api::Ecommerces::ProductSizes::AttributesSerializer
  has_many :image_previews, serializer: Assets::AttributesSerializer
  belongs_to :category, serializer: Api::Ecommerces::Categories::AttributesSerializer

  def image_previews
    object.assets.select { |image| image.type == Asset::IMAGE_PREVIEWS }
  end

  def avatar
    avatar = object.assets.select { |image| image.type == Asset::PRODUCT_AVATAR }.first
    Assets::AttributesSerializer.new(avatar).as_json if avatar
  end

  def product_size_price_min
    price = object.product_sizes.pluck(:price).min

    return price.to_i if object.discount.blank? || !object.is_discount

    (price * (1 - (object.discount / 100))).to_i
  end

  def point_receive
    product_pretax_price =
      BigDecimal(product_size_price_min.to_s) / BigDecimal((1 + (object.tax.to_f / 100)).to_s)
    return 0 if product_pretax_price < 100

    rate_point = object.point_bonus && point_bonus_expried? ? object.point_bonus + 1 : 1
    (product_pretax_price * (rate_point.to_f / 100)).floor
  end

  def point_bonus_expried?
    return false if object.point_start_date.blank? || object.point_end_date.blank?

    Time.current.to_date.between?(object.point_start_date, object.point_end_date)
  end
end

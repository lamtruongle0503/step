# frozen_string_literal: true

class Api::Ecommerces::Orders::Products::MetaSerializer < ApplicationSerializer
  attr_reader :actor

  def initialize(object, options = {})
    super
    @actor = options[:actor]
  end

  attributes :id, :name, :image_preview, :tax, :desired_delivery_date, :is_desired_date_free,
             :is_desired_time_free, :remaining_count, :is_discount, :discount,
             :point_bonus, :point_start_date, :point_end_date, :is_product_size, :is_color, :avatar,
             :option_name, :is_delivery_charges, :delivery_charges_fee, :delivery_time_settings,
             :remaining_limit, :option_color_name
  has_one :coupon, serializer: Api::Ecommerces::Products::Coupons::AttributesSerializer
  belongs_to :category, serializer: Api::Ecommerces::Categories::AttributesSerializer

  def delivery_time_settings
    delivery_times = object.delivery_time_settings.map do |delivery_time|
      Api::Ecommerces::DeliveryTimeSettings::AttributesSerializer.new(delivery_time).as_json
    end
    delivery_times.sort_by! { |t| [t[:start_time], t[:end_time]] }
  end

  def image_preview
    object.assets.select { |image| image.type == Asset::IMAGE_PREVIEWS }.first
  end

  def avatar
    avatar = object.assets.select { |image| image.type == Asset::PRODUCT_AVATAR }.first
    Assets::AttributesSerializer.new(avatar).as_json if avatar
  end

  def remaining_count
    return unless object.is_limit

    object.remaining_count - count_remaining_product(actor.id, object.id)
  end

  def remaining_limit
    return unless object.is_limit

    object.remaining_count - count_remaining_product(actor.id, object.id)
  end

  def coupon
    return unless object.coupon
    return unless Date.today.between?(object.coupon.start_time, object.coupon.end_time)

    object.coupon if actor.ecommerce_coupon_users.find_by(coupon_id: object.coupon.id, is_used: false)
  end
end

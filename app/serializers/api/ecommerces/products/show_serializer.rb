# frozen_string_literal: true

class Api::Ecommerces::Products::ShowSerializer < Api::Ecommerces::Products::AttributesSerializer
  attributes :delivery_amount, :is_use_coupons, :avatar, :option_name, :delivery_time_settings,
             :remaining_limit, :coupon, :option_color_name

  attr_reader :actor

  def initialize(object, options = {})
    super
    @actor = options[:actor]
  end

  has_many :product_sizes, serializer: Api::Ecommerces::ProductSizes::AttributesSerializer
  has_many :image_previews, serializer: Assets::AttributesSerializer
  has_many :image_details, serializer: Assets::AttributesSerializer
  has_many :image_backgrounds, serializer: Assets::AttributesSerializer
  has_many :product_area_settings, serializer: Api::Ecommerces::ProductAreaSettings::AttributesSerializer
  has_many :payments, serializer: Api::Ecommerces::Payments::AttributesSerializer
  has_many :deliveries, serializer: Api::Ecommerces::Deliveries::AttributesSerializer
  belongs_to :category, serializer: Api::Ecommerces::Categories::AttributesSerializer
  belongs_to :agency, serializer: Api::Ecommerces::Agencies::ShowSerializer

  def delivery_time_settings
    delivery_times = object.delivery_time_settings.map do |delivery_time|
      Api::Ecommerces::DeliveryTimeSettings::AttributesSerializer.new(delivery_time).as_json
    end
    delivery_times.sort_by! { |t| [t[:start_time], t[:end_time]] }
  end

  def image_previews
    object.assets.select { |image| image.type == Asset::IMAGE_PREVIEWS }
  end

  def image_details
    object.assets.select { |image| image.type == Asset::IMAGE_DETAILS }
  end

  def avatar
    avatar = object.assets.select { |image| image.type == Asset::PRODUCT_AVATAR }.first
    Assets::AttributesSerializer.new(avatar).as_json if avatar
  end

  def image_backgrounds
    object.assets.select { |image| image.type == Asset::IMAGE_BACKGROUNDS }
  end

  def is_use_coupons # rubocop:disable Naming/PredicateName
    return false unless object.coupon && actor.present?

    coupon = actor.ecommerce_coupon_users.find_by(coupon_id: object.coupon.id)
    return coupon.is_used if coupon

    false
  end

  def remaining_count
    return unless object.is_limit

    object.remaining_count
  end

  def remaining_limit
    return unless object.is_limit

    if actor.present?
      object.remaining_count - count_remaining_product(actor.id, object.id)
    else
      object.remaining_count
    end
  end

  def coupon
    return if object.coupon && object.coupon.end_time < Date.today
    return if actor.present? && EcommerceCouponUser.find_by(coupon: object.coupon, user: actor)&.is_used

    if object.coupon # rubocop:disable Style/GuardClause
      Api::Ecommerces::Products::Coupons::AttributesSerializer.new(object.coupon, { actor: actor }).as_json
    end
  end
end

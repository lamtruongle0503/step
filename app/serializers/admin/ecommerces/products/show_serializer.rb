# frozen_string_literal: true

class Admin::Ecommerces::Products::ShowSerializer <
      Admin::Ecommerces::Products::AttributesSerializer
  attributes :description, :discount, :is_discount, :colors, :remaining_count,
             :is_limit, :description_info, :brand, :original_country, :exp_date,
             :desired_delivery_date, :distributor, :precaution, :hash_tag, :option_color_name,
             :is_desired_date_free, :is_desired_time_free, :tax, :shipping_memo, :shipping_others,
             :is_product_size, :point_bonus, :point_start_date, :point_end_date, :avatar, :option_name,
             :delivery_time_settings

  has_many :product_sizes, serializer: Admin::Ecommerces::ProductSizes::AttributesSerializer
  has_many :image_previews, serializer: Assets::AttributesSerializer
  has_many :image_details, serializer: Assets::AttributesSerializer
  has_many :image_backgrounds, serializer: Assets::AttributesSerializer
  has_many :product_area_settings, serializer: Admin::Ecommerces::ProductAreaSettings::AttributesSerializer
  has_one :coupon, serializer: Admin::Coupons::AttributesSerializer
  belongs_to :agency, serializer: Admin::Ecommerces::Agencies::AttributesSerializer

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

  def image_backgrounds
    object.assets.select { |image| image.type == Asset::IMAGE_BACKGROUNDS }
  end

  def avatar
    avatar = object.assets.select { |image| image.type == Asset::PRODUCT_AVATAR }.first
    Assets::AttributesSerializer.new(avatar).as_json if avatar
  end

  def colors
    object.colors&.split(/、|, |,|,、/)&.compact_blank
  end
end

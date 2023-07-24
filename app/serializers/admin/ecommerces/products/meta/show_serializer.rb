# frozen_string_literal: true

class Admin::Ecommerces::Products::Meta::ShowSerializer < ApplicationSerializer
  attributes :id, :name, :code, :colors, :remaining_count, :tax, :discount,
             :is_discount, :is_product_size, :is_color, :is_desired_date_free,
             :is_desired_time_free, :is_limit, :delivery_time_settings,
             :option_name, :option_color_name, :point_bonus, :point_start_date,
             :point_end_date, :delivery_charges_fee, :is_delivery_charges

  def colors
    object.colors&.split(/、|, |,|,、/)&.compact_blank
  end

  has_many :payments, serializer: Api::Ecommerces::Payments::AttributesSerializer
  has_many :deliveries, serializer: Api::Ecommerces::Deliveries::AttributesSerializer
  has_many :product_sizes, serializer: Admin::Ecommerces::ProductSizes::AttributesSerializer
  has_one :coupon, serializer: Admin::Coupons::AttributesSerializer
  belongs_to :agency, serializer: Admin::Ecommerces::Agencies::AttributesSerializer

  def delivery_time_settings
    delivery_times = object.delivery_time_settings.map do |delivery_time|
      Api::Ecommerces::DeliveryTimeSettings::AttributesSerializer.new(delivery_time).as_json
    end
    delivery_times.sort_by! { |t| [t[:start_time], t[:end_time]] }
  end
end

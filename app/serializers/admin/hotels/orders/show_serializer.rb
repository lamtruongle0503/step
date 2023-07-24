# frozen_string_literal: true

class Admin::Hotels::Orders::ShowSerializer < Admin::Hotels::Orders::AttributesSerializer
  attributes :cancellation_free, :cancellation_type, :childrens, :comments, :discount_amount, :manifest,
             :number_night, :people_statistic, :phone_reciprocal_time, :registrar_name, :registration_pattern,
             :options, :reservation_amount, :hotel_room, :tax_service, :time_estimate, :cancellation_free,
             :prefecture, :area, :cancellation_policy, :adult_total, :hotel_meal, :total_plan, :price_room,
             :hotel_accompany, :cancellation_other_reason, :cancellation_fee, :people_statistic,
             :childrens, :room_options, :total_room

  belongs_to :hotel, serializer: Admin::Hotels::Meta::IndexSerializer
  belongs_to :hotel_plan, serializer: Admin::Hotels::Plans::ShowSerializer

  def hotel_room
    Admin::Hotels::Rooms::AttributesSerializer.new(object.hotel_room).as_json
  end

  def hotel_accompany
    object.hotel_order_accompany
  end

  def options
    Hotel::Option.where(id: object.option_ids).map do |option|
      Admin::Hotels::Options::AttributesSerializer.new(option).as_json
    end
  end

  def prefecture
    Admin::Prefectures::AttributesSerializer.new(object.hotel.prefecture).as_json
  end

  def area
    Admin::AreaSettings::AttributesSerializer.new(object.hotel.area_setting).as_json
  end

  def cancellation_policy
    Admin::Hotels::CancellationPolicies::Meta::IndexSerializer
      .new(object.hotel_plan.hotel_cancellation_policy).as_json
  end

  def hotel_meal
    Admin::Hotels::Meals::AttributesSerializer.new(object.hotel_plan.hotel_meal).as_json
  end

  def total_plan
    object.price_room + object.price_option + object.price_children
  end

  def room_options
    return unless object.hotel_order_log.present?

    if object.hotel_order_log.hotel_order_params['checkout'] # order app
      object.hotel_order_log.hotel_order_params['checkout']['room_options']
    else
      man = object.hotel_order_log.hotel_order_params['man'] # order admin
      women = object.hotel_order_log.hotel_order_params['women']

      { total_man: man, total_women: women }
    end
  end
end

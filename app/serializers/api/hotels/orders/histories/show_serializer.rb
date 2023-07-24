# frozen_string_literal: true

class Api::Hotels::Orders::Histories::ShowSerializer < Api::Hotels::Orders::Histories::AttributesSerializer
  attributes :hotel_name, :hotel_plan, :is_meal, :check_in, :check_out, :adult_total, :person_total,
             :number_night, :hotel_options, :used_points, :time_estimate,
             :price_room, :price_children, :price_sale_off_stay_night, :type,
             :point_receive, :point_bonus, :coupon
  belongs_to :user_contact, serializer: Api::Users::Histories::ShowSerializer
  belongs_to :user, serializer: Api::Users::Histories::ShowSerializer
  belongs_to :hotel_order_accompany, serializer: Api::Users::Histories::ShowSerializer

  def hotel_name
    object.hotel.name
  end

  def hotel_plan
    object.hotel_plan.name
  end

  def is_meal # rubocop:disable Naming/PredicateName
    object.hotel_plan.type_meal.map do |item|
      Hotel::Plan.meals.keys[item.to_i]
    end
  end

  def hotel_options
    object.hotel_order_log.hotel_order_params['hotel_options']
  end

  def coupon
    object.hotel_order_log.hotel_order_params['coupon']
  end

  def type
    object.hotel.class.name
  end

  def point_receive
    object.hotel_plan.point_receive
  end

  def point_bonus
    object.hotel_plan.point_bonus
  end
end

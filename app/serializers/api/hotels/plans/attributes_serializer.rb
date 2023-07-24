# frozen_string_literal: true

class Api::Hotels::Plans::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :type_meal, :type_plan, :setting_check_in_out, :check_in,
             :check_out, :is_sale_off, :setting_sale_off, :setting_children, :hotel_meal,
             :setting_number_night_stay, :from_night, :to_night, :payments, :point_receive,
             :point_bonus

  def setting_sale_off
    object.setting_sale_off.map do |item|
      JSON.parse(item.gsub('=>', ':'))
    end
  end

  def hotel_meal
    Api::Hotels::Meals::AttributesSerializer.new(object.hotel_meal).as_json
  end

  def type_meal
    object.type_meal.map do |item|
      Hotel::Plan.meals.keys[item.to_i]
    end
  end

  def payments
    object.payments.map do |item|
      Hotel::Plan.method_payments.keys[item.to_i]
    end
  end
end

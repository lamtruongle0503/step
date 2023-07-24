# frozen_string_literal: true

class Admin::Hotels::Plans::AttributesSerializer < ApplicationSerializer
  attributes :id, :management_name, :name, :type_meal, :rate_type, :setting_show,
             :type_plan, :payments, :setting_payments, :day_hidden,
             :start_stay_date, :end_stay_date, :setting_limit, :setting_number_night_stay,
             :setting_sale_off, :setting_children, :setting_limit_room, :setting_check_in_out

  def setting_sale_off
    object.setting_sale_off.map do |item|
      JSON.parse(item.gsub('=>', ':'))
    end
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

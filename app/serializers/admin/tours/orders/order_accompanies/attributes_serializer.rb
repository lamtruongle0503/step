# frozen_string_literal: true

class Admin::Tours::Orders::OrderAccompanies::AttributesSerializer < ApplicationSerializer
  attributes :id, :address1, :address2, :birth_day, :departure_start_location,
             :depature_time, :email, :first_name, :last_name, :first_name_kana,
             :last_name_kana, :full_name, :furigana, :gender, :is_owner, :is_save,
             :phone_number, :pickup_location, :post_code, :selected_seat,
             :tour_special_food, :tour_option, :telephone, :is_user, :code

  def code
    return unless (object.is_user.present? || object.is_owner.present?) && object.tour_order.user.present?

    object.tour_order.user.code
  end

  def tour_special_food
    return unless object.tour_special_food

    Admin::Tours::Orders::TourOptions::AttributesSerializer.new(object.tour_special_food).as_json
  end

  def tour_option
    return unless object.tour_option

    Admin::Tours::Orders::TourSpecialFoods::AttributesSerializer.new(object.tour_option).as_json
  end
end

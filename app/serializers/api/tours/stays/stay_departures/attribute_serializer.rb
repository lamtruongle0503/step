# frozen_string_literal: true

class Api::Tours::Stays::StayDepartures::AttributeSerializer < ApplicationSerializer
  attributes :id, :concentrate_time, :depature_time, :four_person_fee, :one_person_fee, :setting_date,
             :three_person_fee, :two_person_fee, :name, :address, :prefecture, :min_price_calendar,
             :is_setting, :code

  def prefecture
    object.prefecture.name
  end

  def four_person_fee
    object.four_person_fee.to_i - object.tour.discount.to_i
  end

  def three_person_fee
    object.three_person_fee.to_i - object.tour.discount.to_i
  end

  def two_person_fee
    object.two_person_fee.to_i - object.tour.discount.to_i
  end

  def one_person_fee
    object.one_person_fee.to_i - object.tour.discount.to_i
  end

  def min_price_calendar
    # [four_person_fee, four_person_fee, two_person_fee, one_person_fee].min
    object.tour.tour_information.min_price.to_i - object.tour.discount.to_i
  end
end

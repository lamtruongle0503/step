# frozen_string_literal: true

class Admin::Tours::Orders::OrderLog::AttributesSerializer < ApplicationSerializer
  attributes :tour, :price_special_food, :tour_options, :tour_information,
             :tour_stay_departures, :amount_tour_bus_seat_map, :company_name,
             :category_name, :company_staff

  def tour
    { tour_name:          object.tour['name'],
      tour_code:          object.tour['code'],
      tour_type_locate:   object.tour['type_locate'],
      tour_title:         object.tour['title'],
      exp_point_bonus:    object.tour['exp_point_bonus'],
      exp_point_receive:  object.tour['exp_point_receive'],
      point_bonus_rate:   object.tour['point_bonus_rate'],
      point_receive_rate: object.tour['point_receive_rate'],
      start_date:         object.tour['start_date'],
      tax:                object.tour['tax'] }
  end

  def company_name
    Tour::Company.find(object.tour['tour_company_id']).name
  end

  def category_name
    Tour::Category.find(object.tour['tour_category_id']).name
  end

  def company_staff
    CompanyStaff.find(object.tour['company_staff_id']).name
  end

  def price_special_food
    object.price_special_food
  end

  def tour_options
    object.tour_options.map do |tour_option|
      tour_option
    end
  end

  def tour_information
    object.tour_information.merge!(object.price_tour_information)
  end

  def tour_stay_departures
    {
      one_person_fee:   (object.tour_stay_departures['one_person_fee'].to_f -
                         object.tour['discount'].to_f).round,
      two_person_fee:   (object.tour_stay_departures['two_person_fee'].to_f -
                         object.tour['discount'].to_f).round,
      three_person_fee: (object.tour_stay_departures['three_person_fee'].to_f -
                         object.tour['discount'].to_f).round,
      four_person_fee:  (object.tour_stay_departures['four_person_fee'].to_f -
                         object.tour['discount'].to_f).round,
    }
  end

  def amount_tour_bus_seat_map
    object.amount_tour_bus_seat_map
  end

  def amount_special_food
    object.price_special_food
  end
end

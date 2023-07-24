# frozen_string_literal: true

class Api::Tours::Orders::OrderLog::AttributeSerializer < ApplicationSerializer
  attributes :tour, :price_special_food, :tour_options, :tour_information,
             :tour_stay_departures, :amount_tour_bus_seat_map, :amount_special_food,
             :tour_hostels

  def tour
    { tour_name:        object.tour['name'],
      tour_code:        object.tour['code'],
      tour_type_locate: object.tour['type_locate'],
      tour_title:       object.tour['title'],
      tax:              object.tour['tax'],
      stayed_nights:    object.tour['stayed_nights'],
      start_date:       object.tour['start_date'],
      end_date:         object.tour['end_date'] }
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
    object.price_tour_information
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

  def tour_hostels
    return unless object.tour_hostels

    JSON.parse(object.tour_hostels)
  end
end

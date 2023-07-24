# frozen_string_literal: true

class Admin::Tours::BusInfos::AttributesSerializer < ApplicationSerializer
  attributes :id, :bus_no, :hitchhike, :departure_date, :day_of_week, :is_weekend,
             :amount_user_ordered, :amount_option_foods, :available_seats,
             :tour_start_location, :tour_bus_pattern, :seats_map, :full_flags,
             :operation_status, :concentrate_time, :departure_time, :tour_information,
             :tour_stay_departure
  attr_reader :tour, :tour_orders

  def initialize(object, options = {})
    super
    @tour = object.tour
    @tour_orders = object.tour_orders.includes(:tour_order_accompanies, :tour_order_log)
  end

  def tour_information
    Admin::Tours::Informations::AttributesSerializer.new(tour.tour_information).as_json
  end

  def tour_start_location
    return unless object.tour_start_location

    Admin::Tours::StartLocations::BusInfos::AttributesSerializer.new(object.tour_start_location).as_json
  end

  def tour_stay_departure
    return unless object.tour_stay_departure

    Admin::Tours::StayDepartures::BusInfos::AttributesSerializer.new(object.tour_stay_departure).as_json
  end

  def tour_bus_pattern
    Admin::Tours::BusPatterns::BusInfos::AttributesSerializer.new(object.tour_bus_pattern).as_json
  end

  def hitchhike; end

  def amount_option_foods
    return unless tour_orders.find_tour_order_by_tour_id(object.tour_id)

    if object.tour.type_locate == Tour::STAY
      tour_option_number
    else
      special_food_number
    end
  end

  def tour_option_number
    tour_option_number = []
    object.tour_orders.find_tour_order_by_tour_id(object.tour_id).each do |tour_order|
      if tour_order.tour_order_log && tour_order.status == Tour::Order::BOOKED
        tour_option_number += tour_order.tour_order_log.tour_options
      end
    end
    tour_option_number
  end

  def special_food_number
    special_numbers = []
    tour_orders.find_tour_order_by_tour_id(object.tour_id).each do |tour_order|
      if tour_order.tour_order_log && tour_order.status == Tour::Order::BOOKED
        special_numbers << tour_order.tour_order_log.price_special_food
      end
    end
    special_numbers
  end

  def amount_user_ordered
    amount_user_ordered = 0
    tour_orders.find_tour_order_by_tour_id(object.tour_id)
               .by_status_not_in_cancel_and_special.each do |tour_order|
      amount_user_ordered += tour_order.tour_order_accompanies.size
    end
    amount_user_ordered
  end

  def full_flags
    I18n.t('order_tours.bus_infos.full_flag') if object.available_seats.zero?
  end
end

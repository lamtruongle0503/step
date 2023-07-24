# frozen_string_literal: true

class Admin::Tours::BusInfos::ShowSerializer < ApplicationSerializer
  attributes :id, :bus_no, :hitchhike, :departure_date, :day_of_week, :is_weekend,
             :amount_user_ordered, :amount_option_foods, :available_seats,
             :initial_price, :discount_amount, :total, :tour_start_location,
             :tour_bus_pattern, :tours_management, :seats_map, :full_flags,
             :operation_status, :concentrate_time, :departure_time, :tour_information,
             :amount_list_temporary
  attr_reader :tour, :tour_orders

  def initialize(object, options = {})
    super
    @tour = object.tour
    @tour_orders = object.tour_orders.includes(:tour_order_log)
  end

  def tours_management
    Admin::Tours::Managements::BusInfos::AttributesSerializer.new(object.tour).as_json
  end

  def tour_information
    Admin::Tours::Informations::AttributesSerializer.new(tour.tour_information).as_json
  end

  def amount_list_temporary
    tour.tour_temporaries.size
  end

  def tour_start_location
    if object.tour.type_locate == Tour::STAY
      Admin::Tours::StayDepartures::BusInfos::AttributesSerializer.new(object.tour_stay_departure).as_json
    else
      Admin::Tours::StartLocations::BusInfos::AttributesSerializer.new(object.tour_start_location).as_json
    end
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
    tour_orders.find_tour_order_by_tour_id(object.tour_id).each do |tour_order|
      tour_option_number += tour_order.tour_order_log.tour_options
    end
    tour_option_number
  end

  def special_food_number
    special_numbers = []
    tour_orders.find_tour_order_by_tour_id(object.tour_id).each do |tour_order|
      special_numbers << tour_order.tour_order_log.price_special_food
    end
    special_numbers
  end

  def amount_user_ordered
    amount_user_ordered = 0
    tour_orders.find_tour_order_by_tour_id(object.tour_id)
               .by_status_not_in_cancel_and_special.each do |tour_order|
      amount_user_ordered += tour_order.tour_order_accompanies.count
    end
    amount_user_ordered
  end

  def initial_price
    sum_initial_price = 0
    tour_orders.select do |order|
      sum_initial_price += order.initial_price if order.tour_id == object.tour_id
    end
    sum_initial_price
  end

  def discount_amount
    sum_discount_amount = 0
    tour_orders.select do |order|
      sum_discount_amount += order.discount_amount.to_i if order.tour_id == object.tour_id
    end
    sum_discount_amount
  end

  def total
    sum_total = 0
    tour_orders.select do |order|
      sum_total += order.total if order.tour_id == object.tour_id
    end
    sum_total
  end

  def full_flags
    object.seats_map.each do |seats|
      seats.each do |seat|
        return [] if seat['status'] == Tour::BusInfo::OPEN && seat['type'] != Tour::BusInfo::HIDE
      end
    end
    I18n.t('order_tours.bus_infos.full_flag')
  end
end

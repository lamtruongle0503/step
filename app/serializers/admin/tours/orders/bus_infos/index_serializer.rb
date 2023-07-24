# frozen_string_literal: true

class Admin::Tours::Orders::BusInfos::IndexSerializer < ApplicationSerializer
  attributes :id, :available_seats, :bus_no, :day_of_week, :departure_date, :is_weekend, :reserved_seats,
             :tour_stay_departure, :tour_start_location, :tour_bus_pattern

  def tour_stay_departure
    return unless object.tour_stay_departure

    Admin::Tours::Orders::TourStayDepartures::AttributesSerializer.new(object.tour_stay_departure).as_json
  end

  def tour_start_location
    return unless object.tour_start_location

    Admin::Tours::Orders::TourStartLocations::AttributesSerializer.new(object.tour_start_location).as_json
  end

  def tour_bus_pattern
    Admin::Tours::Orders::BusPattern::AttributesSerializer.new(object.tour_bus_pattern).as_json
  end
end

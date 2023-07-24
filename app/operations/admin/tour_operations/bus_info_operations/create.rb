# frozen_string_literal: true

require 'tour/bus_info'
class Admin::TourOperations::BusInfoOperations::Create < ApplicationOperation
  attr_reader :tour, :bus_pattern

  def initialize(actor, params)
    super
    @tour        = Tour.find(params[:management_id])
    @bus_pattern = Tour::BusPattern.find(params[:tour_bus_pattern_id])
  end

  def call
    authorize nil, Tour::Management::BusInfoPolicy

    ActiveRecord::Base.transaction do
      create_tour_bus_info!
    end
  end

  private

  def create_tour_bus_info!
    TourContracts::BusInfoContracts::Create.new(tour_bus_info_params).valid!
    tour.tour_bus_infos.create!(tour_bus_info_params.merge(
                                  available_seats: bus_pattern.capacity,
                                  reserved_seats:  0,
                                  seats_map:       bus_pattern.map,
                                ))
  end

  def tour_bus_info_params
    params.permit(:departure_date, :day_of_week, :is_weekend, :bus_no, :operation_status,
                  :tour_start_location_id, :tour_bus_pattern_id, :tour_stay_departure_id,
                  :concentrate_time, :departure_time, :tour_place_start_id)
  end
end

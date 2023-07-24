# frozen_string_literal: true

require 'tour/bus_info'
class Admin::TourOperations::BusInfoOperations::Update < ApplicationOperation
  attr_reader :tour, :tour_bus_info, :bus_pattern

  def initialize(actor, params)
    super
    @tour          = Tour.find(params[:management_id])
    @tour_bus_info = tour.tour_bus_infos.find(params[:id])
    @bus_pattern   = Tour::BusPattern.find(params[:tour_bus_pattern_id])
  end

  def call
    authorize nil, Tour::Management::BusInfoPolicy

    ActiveRecord::Base.transaction do
      check_update_bus_info!
      update_tour_bus_info!
      update_tour_order!
    end
  end

  private

  def check_update_bus_info! # rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
    tour_bus_info.seats_map.each do |seat_map|
      seat_map.each do |seat|
        next unless seat['status'] == Tour::BusInfo::BOOKING && seat['type'] != Tour::BusPattern::HIDE &&
                    (tour_bus_info_params[:tour_bus_pattern_id]&.to_i != tour_bus_info.tour_bus_pattern_id &&
                         tour_bus_info_params[:tour_id] != tour_bus_info.tour_id &&
                         tour_bus_info_params[:day_of_week] != tour_bus_info.day_of_week &&
                         tour_bus_info_params[:is_weekend] != tour_bus_info.is_weekend &&
                         tour_bus_info_params[:bus_no] != tour_bus_info.bus_no &&
                         tour_bus_info_params[:operation_status] != tour_bus_info.operation_status)

        raise BadRequestError,
              bus: I18n.t('order_tours.bus_infos.bus_full_flag')
      end
    end
  end

  def update_tour_bus_info!
    TourContracts::BusInfoContracts::Update.new(tour_bus_info_params).valid!
    if Tour::Order.where(tour_bus_info_id: tour_bus_info.id).blank?
      tour_bus_info.update!(tour_bus_info_params.merge(
                              available_seats: bus_pattern.capacity,
                              reserved_seats:  0,
                              seats_map:       bus_pattern.map,
                            ))
    else
      tour_bus_info.update!(tour_bus_info_params)
    end
  end

  def update_tour_order!
    Tour::Order.where(tour_bus_info_id: tour_bus_info.id)
               .update_all(
                 concentrate_time: tour_bus_info.concentrate_time,
                 depature_time:    tour_bus_info.departure_time,
               )
  end

  def tour_bus_info_params
    params.permit(:departure_date, :day_of_week, :is_weekend, :bus_no, :operation_status,
                  :tour_start_location_id, :tour_bus_pattern_id, :tour_stay_departure_id,
                  :concentrate_time, :departure_time, :tour_place_start_id)
  end
end

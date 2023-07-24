# class TourContracts::BusPatternContracts::Update
# frozen_string_literal: true

require 'tour/bus_pattern'
class Admin::TourOperations::BusPatternOperations::Update < ApplicationOperation
  attr_reader :tour_bus_pattern

  def initialize(actor, params)
    super
    @tour_bus_pattern = Tour::BusPattern.find(params[:id])
  end

  def call
    authorize nil, Tour::Management::BusPatternPolicy

    ActiveRecord::Base.transaction do
      check_update_bus_pattern!
    end
  end

  private

  def check_update_bus_pattern!
    tour_bus_infos = tour_bus_pattern.bus_infos
    if tour_bus_infos.present?
      tour_bus_infos.each do |bus_info|
        bus_info.seats_map.each do |seat_map|
          seat_map.each do |seat|
            if seat['status'] == Tour::BusInfo::BOOKING && seat['type'] != Tour::BusPattern::HIDE
              raise BadRequestError,
                    bus: I18n.t('order_tours.bus_infos.bus_full_flag')
            end
          end
        end
      end
    end
    update_tour_bus_pattern!
  end

  def update_tour_bus_pattern!
    TourContracts::BusPatternContracts::Update.new(
      tour_bus_pattern_params.merge!(record: tour_bus_pattern, seat_map: params[:map].as_json),
    ).valid!
    tour_bus_pattern.update!(
      name:     tour_bus_pattern_params[:name],
      capacity: tour_bus_pattern_params[:capacity],
      map:      params[:map].as_json,
    )
    update_bus_infos(tour_bus_pattern) if tour_bus_pattern.bus_infos.present?
  end

  def update_bus_infos(tour_bus_pattern)
    tour_bus_pattern.bus_infos.each do |bus_info|
      bus_info.update!(seats_map: tour_bus_pattern.map)
    end
  end

  def tour_bus_pattern_params
    params.permit(:name, :capacity)
  end
end

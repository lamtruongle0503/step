# frozen_string_literal: true

require 'tour/bus_pattern'
class Admin::TourOperations::BusPatternOperations::Destroy < ApplicationOperation
  def call
    authorize nil, Tour::Management::BusPatternPolicy

    tour_bus_pattern = Tour::BusPattern.find(params[:id])
    ActiveRecord::Base.transaction do
      check_destroy_bus_pattern!(tour_bus_pattern)
    end
  end

  def check_destroy_bus_pattern!(tour_bus_pattern)
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
    tour_bus_pattern.destroy!
  end
end

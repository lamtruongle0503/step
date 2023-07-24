# frozen_string_literal: true

require 'tour/bus_info'
class Admin::TourOperations::BusInfoOperations::Destroy < ApplicationOperation
  attr_reader :tour, :tour_bus_info

  def initialize(actor, params)
    super
    @tour          = Tour.find(params[:management_id])
    @tour_bus_info = tour.tour_bus_infos.find(params[:id])
  end

  def call
    authorize nil, Tour::Management::BusInfoPolicy

    ActiveRecord::Base.transaction do
      check_bus_info!
      tour_bus_info.destroy!
    end
  end

  def check_bus_info!
    tour_bus_info.seats_map.each do |seat_map|
      seat_map.each do |seat|
        if seat['status'] == Tour::BusInfo::BOOKING && seat['type'] != Tour::BusPattern::HIDE
          raise BadRequestError,
                bus: I18n.t('order_tours.bus_infos.bus_full_flag')
        end
      end
    end
  end
end

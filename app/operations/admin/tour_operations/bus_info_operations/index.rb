# frozen_string_literal: true

require 'tour/bus_info'
class Admin::TourOperations::BusInfoOperations::Index < ApplicationOperation
  attr_reader :tour, :tour_place_start

  def initialize(actor, params)
    super
    @tour = Tour.find(params[:management_id])
    @tour_place_start = tour.tour_place_starts.find(params[:tour_place_start_id])
  end

  def call
    authorize nil, Tour::Management::BusInfoPolicy

    tour_place_start.tour_bus_infos.includes(:tour, :tour_start_location,
                                             :tour_bus_pattern, :tour_stay_departure)
                    .sorted_by(params[:sort], params[:type_sort])
                    .page(params[:page]).per(50)
  end
end

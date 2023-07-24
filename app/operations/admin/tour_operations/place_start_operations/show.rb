# frozen_string_literal: true

require 'tour/order'
class Admin::TourOperations::PlaceStartOperations::Show < ApplicationOperation
  attr_reader :tour

  def initialize(actor, params)
    super
    @tour = Tour.find(params[:tour_id])
  end

  def call
    authorize nil, TourPolicy
    tour.tour_place_starts.includes(tour_start_locations: [:prefecture],
                                    tour_stay_departures: [:prefecture]).find(params[:id])
  end
end

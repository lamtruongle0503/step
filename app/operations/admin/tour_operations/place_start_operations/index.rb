# frozen_string_literal: true

require 'tour/order'
class Admin::TourOperations::PlaceStartOperations::Index < ApplicationOperation
  attr_reader :tour

  def initialize(actor, params)
    super
    @tour = Tour.find(params[:tour_id])
  end

  def call
    authorize nil, TourPolicy
    @q = tour.tour_place_starts.includes(tour_start_locations: [:prefecture],
                                         tour_stay_departures: [:prefecture]).ransack(params[:q])
    @q.result(distinct: true).newest
  end
end

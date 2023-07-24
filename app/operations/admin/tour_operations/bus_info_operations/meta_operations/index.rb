# frozen_string_literal: true

require 'tour/bus_info'
class Admin::TourOperations::BusInfoOperations::MetaOperations::Index < ApplicationOperation
  attr_reader :tour

  def initialize(actor, params)
    super
    @tour = Tour.find(params[:management_id])
  end

  def call
    authorize nil, Tour::Management::BusInfoPolicy

    tour.tour_bus_infos.includes(
      :tour, :tour_start_location, :tour_bus_pattern,
      :tour_stay_departure
    ).newest
  end
end

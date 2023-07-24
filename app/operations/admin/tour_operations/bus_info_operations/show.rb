# frozen_string_literal: true

require 'tour/bus_info'
class Admin::TourOperations::BusInfoOperations::Show < ApplicationOperation
  attr_reader :tour

  def initialize(actor, params)
    super
    @tour = Tour.find(params[:management_id])
  end

  def call
    authorize nil, Tour::Management::BusInfoPolicy

    tour.tour_bus_infos.find(params[:id])
  end
end

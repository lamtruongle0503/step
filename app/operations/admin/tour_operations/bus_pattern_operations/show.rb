# frozen_string_literal: true

require 'tour/bus_pattern'
class Admin::TourOperations::BusPatternOperations::Show < ApplicationOperation
  def call
    authorize nil, Tour::Management::BusPatternPolicy

    @tour_bus_pattern = Tour::BusPattern.find(params[:id])
  end
end

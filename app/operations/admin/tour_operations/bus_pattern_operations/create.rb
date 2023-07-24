# frozen_string_literal: true

require 'tour/bus_pattern'
class Admin::TourOperations::BusPatternOperations::Create < ApplicationOperation
  def call
    authorize nil, Tour::Management::BusPatternPolicy

    ActiveRecord::Base.transaction do
      create_tour_bus_pattern!
    end
  end

  private

  def create_tour_bus_pattern!
    TourContracts::BusPatternContracts::Create.new(tour_bus_pattern_params).valid!
    Tour::BusPattern.create!(tour_bus_pattern_params)
  end

  def tour_bus_pattern_params
    params.permit(:name, :capacity)
  end
end

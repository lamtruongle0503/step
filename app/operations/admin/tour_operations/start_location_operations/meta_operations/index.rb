# frozen_string_literal: true

require 'tour/start_location'
class Admin::TourOperations::StartLocationOperations::MetaOperations::Index < ApplicationOperation
  attr_reader :tour

  def initialize(actor, params)
    super
    @tour = Tour.find(params[:tour_id])
  end

  def call
    tour.tour_start_locations
  end
end

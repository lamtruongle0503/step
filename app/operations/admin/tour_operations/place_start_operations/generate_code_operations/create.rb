# frozen_string_literal: true

require 'tour/order'
class Admin::TourOperations::PlaceStartOperations::GenerateCodeOperations::Create < ApplicationOperation
  attr_reader :tour

  def initialize(actor, params)
    super
    @tour = Tour.find(params[:tour_id])
  end

  def call
    authorize nil, TourPolicy

    suffix =  tour.tour_place_starts.last&.code&.last(2).to_i
    if suffix.zero?
      "#{tour.code}-01"
    else
      suffix = (suffix + 1).to_s.rjust(2, '0')
      "#{tour.code}-#{suffix}"
    end
  end
end

# frozen_string_literal: true

class Api::TourOperations::Index < ApplicationOperation
  attr_reader :prefecture

  def initialize(actor, params)
    super

    @prefecture = Prefecture.find(params[:prefecture_id]) if params[:prefecture_id].present?
  end

  def call
    return Tour.includes([:assets]).all unless prefecture.present?

    prefecture.tour_start_locations.includes([:tour]).available.map(&:tour) |
      prefecture.tour_stay_departures.includes([:tour]).available.map(&:tour)
  end
end

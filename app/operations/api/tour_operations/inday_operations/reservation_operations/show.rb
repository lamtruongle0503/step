# frozen_string_literal: true

class Api::TourOperations::IndayOperations::ReservationOperations::Show < ApplicationOperation
  def call
    Tour.includes(tour_special_foods: :assets).find(params[:inday_id])
  end
end

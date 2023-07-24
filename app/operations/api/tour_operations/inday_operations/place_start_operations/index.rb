# frozen_string_literal: true

module Api::TourOperations::IndayOperations::PlaceStartOperations
  class Index < ApplicationOperation
    def call
      Tour.includes(tour_place_starts: %i[tour prefecture]).find(params[:inday_id])
    end
  end
end

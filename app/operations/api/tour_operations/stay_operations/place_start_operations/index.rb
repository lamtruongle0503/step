# frozen_string_literal: true

module Api::TourOperations::StayOperations::PlaceStartOperations
  class Index < ApplicationOperation
    def call
      Tour.includes(tour_place_starts: %i[tour tour_stay_departures prefecture]).find(params[:stay_id])
    end
  end
end

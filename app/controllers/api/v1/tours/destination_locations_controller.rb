# frozen_string_literal: true

class Api::V1::Tours::DestinationLocationsController < ApiV1Controller
  def index
    destinations = Api::TourOperations::DestinationLocationOperations::Index.new(nil, params).call
    render json: destinations, root: 'data'
  end
end

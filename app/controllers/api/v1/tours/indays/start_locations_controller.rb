# frozen_string_literal: true

class Api::V1::Tours::Indays::StartLocationsController < ApiV1Controller
  def index
    start_locations = Api::TourOperations::IndayOperations::StartLocationOperations::Index.new(nil,
                                                                                               params).call
    render json:       start_locations,
           serializer: Api::Tours::Indays::StartLocations::IndexSerializer,
           root:       'tours'
  end
end

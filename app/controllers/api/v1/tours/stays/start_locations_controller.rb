# frozen_string_literal: true

class Api::V1::Tours::Stays::StartLocationsController < ApiV1Controller
  def index
    start_locations = Api::TourOperations::StayOperations::StartLocationOperations::Index.new(nil,
                                                                                              params).call
    render json:       start_locations,
           serializer: Api::Tours::Stays::StartLocations::IndexSerializer,
           root:       'tours'
  end
end

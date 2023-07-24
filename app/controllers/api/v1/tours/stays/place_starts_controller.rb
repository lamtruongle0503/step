# frozen_string_literal: true

class Api::V1::Tours::Stays::PlaceStartsController < ApiV1Controller
  def index
    tour = Api::TourOperations::StayOperations::PlaceStartOperations::Index.new(nil, params).call
    render json:       tour,
           serializer: Api::Tours::Stays::PlaceStarts::AttributesSerializer,
           root:       'tours'
  end
end

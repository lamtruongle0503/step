# frozen_string_literal: true

class Api::V1::Tours::Indays::PlaceStartsController < ApiV1Controller
  def index
    tour = Api::TourOperations::IndayOperations::PlaceStartOperations::Index.new(nil, params).call
    render json:       tour,
           serializer: Api::Tours::Indays::PlaceStarts::AttributesSerializer,
           root:       'tours'
  end
end

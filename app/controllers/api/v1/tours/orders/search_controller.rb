# frozen_string_literal: true

class Api::V1::Tours::Orders::SearchController < ApiV1Controller
  before_action :authentication!

  def index
    tour_order = Api::TourOperations::OrderOperations::SearchOperations::Index.new(actor, params).call
    render json: tour_order, serializer: Api::Tours::Orders::Histories::ShowSerializer
  end
end

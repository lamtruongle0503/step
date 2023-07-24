# frozen_string_literal: true

class Api::V1::Tours::Orders::HistoriesController < ApiV1Controller
  before_action :authentication!

  def index
    tour_orders = Api::TourOperations::OrderOperations::HistoryOperations::Index.new(actor, params).call
    render json: tour_orders,
           each_serializer: Api::Tours::Orders::Histories::IndexSerializer,
           meta: pagination_dict(tour_orders), root: 'data', adapter: :json
  end

  def show
    tour_order = Api::TourOperations::OrderOperations::HistoryOperations::Show.new(actor, params).call
    render json: tour_order, serializer: Api::Tours::Orders::Histories::ShowSerializer
  end
end

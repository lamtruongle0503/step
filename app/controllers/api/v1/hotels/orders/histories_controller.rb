# frozen_string_literal: true

class Api::V1::Hotels::Orders::HistoriesController < ApiV1Controller
  def index
    hotel_orders = Api::HotelOperations::OrderOperations::HistoryOperations::Index.new(actor, params).call
    render json: hotel_orders, each_serializer: Api::Hotels::Orders::Histories::IndexSerializer,
           root: 'data', meta: pagination_dict(hotel_orders), adapter: :json
  end

  def show
    hotel_order = Api::HotelOperations::OrderOperations::HistoryOperations::Show.new(actor, params).call
    render json: hotel_order, serializer: Api::Hotels::Orders::Histories::ShowSerializer
  end
end

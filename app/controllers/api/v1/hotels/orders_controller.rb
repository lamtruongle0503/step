# frozen_string_literal: true

class Api::V1::Hotels::OrdersController < ApiV1Controller
  def index
    order = Api::HotelOperations::OrderOperations::Index.new(actor, params).call
    render json: order, serializer: Api::Hotels::Orders::Histories::ShowSerializer
  end
end

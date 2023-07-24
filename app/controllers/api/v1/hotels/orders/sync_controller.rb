# frozen_string_literal: true

class Api::V1::Hotels::Orders::SyncController < ApiV1Controller
  def create
    Api::HotelOperations::OrderOperations::SyncOperations::Create.new(nil, params).call
    render json: {}
  end
end

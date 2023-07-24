# frozen_string_literal: true

class Api::V1::Hotels::Orders::CancellationsController < ApiV1Controller
  def update
    Api::HotelOperations::OrderOperations::CancellationOperations::Update.new(actor, params).call
    render json: {}
  end
end

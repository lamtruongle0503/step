# frozen_string_literal: true

class Api::V1::Hotels::RequestsController < ApiV1Controller
  def create
    request = Api::HotelOperations::RequestOperations::Create.new(actor, params).call
    render json: request
  end

  def show
    request = Api::HotelOperations::RequestOperations::Show.new(actor, params).call
    render json: request, serializer: Api::Hotels::Requests::ShowSerializer
  end
end

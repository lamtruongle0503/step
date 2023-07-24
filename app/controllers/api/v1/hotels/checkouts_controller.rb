# frozen_string_literal: true

class Api::V1::Hotels::CheckoutsController < ApiV1Controller
  before_action :authentication!

  def create
    order = Api::HotelOperations::CheckoutOperations::Create.new(actor, params).call
    render json: order, serializer: Api::Hotels::Checkouts::AttributesSerializer, root: 'order'
  end

  def update
    Api::HotelOperations::CheckoutOperations::Update.new(actor, params).call
    render json: {}
  end
end

# frozen_string_literal: true

class Api::V1::Tours::Orders::CheckoutsController < ApiV1Controller
  before_action :authentication!

  def create
    Api::TourOperations::OrderOperations::CheckoutOperations::Create.new(actor, params).call
    render json: {}
  end
end

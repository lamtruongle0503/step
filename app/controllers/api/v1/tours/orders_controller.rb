# frozen_string_literal: true

class Api::V1::Tours::OrdersController < ApiV1Controller
  before_action :authentication!

  def create
    Api::TourOperations::OrderOperations::Create.new(actor, params).call
    render json: {}
  end
end

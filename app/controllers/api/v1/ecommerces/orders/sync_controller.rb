# frozen_string_literal: true

class Api::V1::Ecommerces::Orders::SyncController < ApiV1Controller
  def create
    Api::EcommerceOperations::OrderOperations::SyncOperations::Create.new(nil, params).call
    render json: {}
  end
end

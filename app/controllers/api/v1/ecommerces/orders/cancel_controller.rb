# frozen_string_literal: true

class Api::V1::Ecommerces::Orders::CancelController < ApiV1Controller
  before_action :authentication!

  def create
    render json: Api::EcommerceOperations::OrderOperations::CancelOperations::Create.new(actor, params).call,
           serializer: Api::Ecommerces::Orders::Cancel::CreateSerializer, root: 'ecommerces'
  end
end

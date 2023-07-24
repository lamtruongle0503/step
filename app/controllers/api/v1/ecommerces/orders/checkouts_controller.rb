# frozen_string_literal: true

class Api::V1::Ecommerces::Orders::CheckoutsController < ApiV1Controller
  before_action :authentication!

  def create
    checkout = Api::EcommerceOperations::OrderOperations::CheckoutOperations::Create.new(actor, params).call
    render json: checkout,
           serializer: Api::Ecommerces::Orders::Checkouts::CreateSerializer, root: 'ecommerces'
  end
end

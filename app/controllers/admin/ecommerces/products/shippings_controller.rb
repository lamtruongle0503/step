# frozen_string_literal: true

class Admin::Ecommerces::Products::ShippingsController < ApiV1Controller
  before_action :authentication!

  def index
    render json: Admin::EcommerceOperations::ProductOperations::ShippingOperations::Index.new(
      actor, params
    ).call,
           serializer: Admin::Ecommerces::Products::Shippings::IndexSerializer, root: 'ecommerces'
  end
end

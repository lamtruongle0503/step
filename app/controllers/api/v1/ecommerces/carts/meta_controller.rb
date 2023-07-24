# frozen_string_literal: true

class Api::V1::Ecommerces::Carts::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    number = Api::EcommerceOperations::CartOperations::Meta.new(actor, params).call
    render json: number, serializer: Api::Ecommerces::Carts::MetaSerializer, root: 'cart'
  end
end

# frozen_string_literal: true

class Api::V1::Ecommerces::CartsController < ApiV1Controller
  before_action :authentication!

  def create
    render json: Api::EcommerceOperations::CartOperations::Create.new(actor, params).call,
           serializer: Api::Ecommerces::Carts::CreateSerializer, root: 'ecommerces'
  end

  def index
    orders = Api::EcommerceOperations::CartOperations::Index.new(actor, params).call
    render json: orders,
           each_serializer: Api::Ecommerces::Carts::IndexSerializer, actor: actor,
           meta: pagination_dict(orders), root: 'data', adapter: :json
  end

  def update
    render json: Api::EcommerceOperations::CartOperations::Update.new(actor, params).call,
           serializer: Api::Ecommerces::Carts::IndexSerializer, root: 'ecommerces', actor: actor
  end

  def destroy
    render json: Api::EcommerceOperations::CartOperations::Destroy.new(actor, params).call,
           serializer: Api::Ecommerces::Carts::DestroySerializer, root: 'ecommerces'
  end
end

# frozen_string_literal: true

class Api::V1::Ecommerces::OrdersController < ApiV1Controller
  before_action :authentication!

  def create
    render json: Api::EcommerceOperations::OrderOperations::Create.new(actor, params).call,
           serializer: Api::Ecommerces::Orders::CreateSerializer, root: 'ecommerces'
  end

  def show
    render json: Api::EcommerceOperations::OrderOperations::Show.new(actor, params).call,
           serializer: Api::Ecommerces::Orders::ShowSerializer, actor: actor,
           root: 'ecommerces'
  end

  def index
    orders = Api::EcommerceOperations::OrderOperations::Index.new(actor, params).call
    render json: orders,
           each_serializer: Api::Ecommerces::Orders::IndexSerializer, actor: actor,
           meta: pagination_dict(orders), root: 'data', adapter: :json
  end
end

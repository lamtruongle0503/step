# frozen_string_literal: true

class Admin::Ecommerces::OrdersController < ApiV1Controller
  before_action :authentication!

  def index
    orders = Admin::EcommerceOperations::OrderOperations::Index.new(actor, params).call
    render json: orders, each_serializer: Admin::Ecommerces::Orders::IndexSerializer,
           meta: pagination_dict(orders), root: 'data', adapter: :json
  end

  def show
    order = Admin::EcommerceOperations::OrderOperations::Show.new(actor, params).call
    render json: order, serializer: Admin::Ecommerces::Orders::ShowSerializer
  end

  def update
    render json: Admin::EcommerceOperations::OrderOperations::Update.new(actor, params).call,
           serializer: Admin::Ecommerces::Orders::UpdateSerializer, root: 'orders'
  end

  def create
    Admin::EcommerceOperations::OrderOperations::Create.new(actor, params).call
    render json: {}
  end
end

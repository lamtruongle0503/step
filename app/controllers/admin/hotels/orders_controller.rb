# frozen_string_literal: true

class Admin::Hotels::OrdersController < ApiV1Controller
  before_action :authentication!

  def create
    Admin::HotelOperations::OrderOperations::Create.new(actor, params).call
    render json: {}
  end

  def index
    orders = Admin::HotelOperations::OrderOperations::Index.new(actor, params).call
    render json: orders, each_serializer: Admin::Hotels::Orders::IndexSerializer, root: 'data',
           meta: pagination_dict(orders), adapter: :json
  end

  def show
    order = Admin::HotelOperations::OrderOperations::Show.new(actor, params).call
    render json: order, serializer: Admin::Hotels::Orders::ShowSerializer
  end

  def update
    Admin::HotelOperations::OrderOperations::Update.new(actor, params).call
    render json: {}
  end
end

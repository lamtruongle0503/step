# frozen_string_literal: true

class Admin::Users::OrdersController < ApiV1Controller
  before_action :authentication!

  def index
    orders = Admin::UserOperations::OrderOperations::Index.new(actor, params).call
    render json: orders,
           each_serializer: ::Admin::Users::Orders::IndexSerializer,
           meta: pagination_dict(orders), root: 'data', adapter: :json
  end
end

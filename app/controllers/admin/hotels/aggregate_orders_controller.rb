# frozen_string_literal: true

class Admin::Hotels::AggregateOrdersController < ApiV1Controller
  before_action :authentication!

  def index
    aggregates = Admin::HotelOperations::AggregateOrderOperations::Index.new(actor, params).call
    render json: aggregates, serializer: Admin::Hotels::AggregateOrders::AttributesSerializer,
           root: 'aggregates', adapter: :json
  end
end

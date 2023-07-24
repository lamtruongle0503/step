# frozen_string_literal: true

class Admin::Tours::Managements::Bus::OrdersController < ApiV1Controller
  before_action :authentication!

  def index
    orders = Admin::TourOperations::BusInfoOperations::OrderOperations::Index.new(actor, params).call
    render json: orders,
           each_serializer: Admin::Tours::Managements::BusInfos::Orders::AttributesSerializer,
           root: 'data', adapter: :json
  end
end

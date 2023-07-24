# frozen_string_literal: true

class Admin::Tours::OrdersController < ApiV1Controller
  before_action :authentication!

  def create
    Admin::TourOperations::OrderOperations::Create.new(actor, params).call
    render json: {}
  end

  def show
    tour_order = Admin::TourOperations::OrderOperations::Show.new(actor, params).call
    render json: tour_order, serializer: Admin::Tours::Orders::ShowSerializer, root: 'data'
  end

  def update
    Admin::TourOperations::OrderOperations::Update.new(actor, params).call
    render json: {}
  end
end

# frozen_string_literal: true

class Admin::DeliveriesController < ApiV1Controller
  before_action :authentication!

  def index
    render json:            Admin::DeliveryOperations::Index.new(actor, params).call,
           each_serializer: Admin::Deliveries::IndexSerializer
  end
end

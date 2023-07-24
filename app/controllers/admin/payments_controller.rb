# frozen_string_literal: true

class Admin::PaymentsController < ApiV1Controller
  before_action :authentication!

  def index
    render json: Admin::PaymentOperations::Index.new(actor, params).call,
           each_serializer: Admin::Payments::IndexSerializer, root: 'payments'
  end
end

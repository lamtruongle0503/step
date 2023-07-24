# frozen_string_literal: true

class Api::EcommerceOperations::OrderOperations::CancelOperations::Create < ApplicationOperation
  attr_reader :order

  def initialize(actor, params)
    super
    @order = Order.find(params[:order_id])
  end

  def call
    ActiveRecord::Base.transaction do
      order.update!(order_status: Order::CANCEL)
      update_remain_product(order)
      refund_purchased_amount(order)
    end
  end

  private

  def update_remain_product(order)
    order.order_products.each do |order_product|
      next unless order_product.product_size.is_limit

      order_product.product_size.increment!(:remaining_count, order_product.number)
    end
  end

  def refund_purchased_amount(order)
    return unless order.payment.code == Order::CREDIT_CARD && order.payment_status == Order::SUCCEEDED

    purchased_id = order.purchased_id
    refund = StripeService.refund(purchased_id, 'requested_by_customer')
    if refund.status == Order::SUCCEEDED
      order.update!(payment_status: Order::REFUNED)
    else
      order.update!(payment_status: Order::PENDING)
    end
  end
end

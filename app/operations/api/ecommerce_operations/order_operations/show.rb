# frozen_string_literal: true

class Api::EcommerceOperations::OrderOperations::Show < ApplicationOperation
  attr_reader :address

  def initialize(actor, params)
    super
    @address = Address.find(params[:address_id]) if params[:address_id]
  end

  def call
    order = Order.includes(:product_sizes,
                           order_products: [product: %i[coupon assets
                                                        delivery_time_settings]]).find(params[:id])
    delivery_amount            = calc_product_shipping_fee(order, params[:address_id])
    delivery_free_amount       = calc_order_shipping_free_fee(order, params[:address_id])
    order.delivery_free_amount = delivery_free_amount
    order.delivery_amount      = delivery_amount
    order
  end
end

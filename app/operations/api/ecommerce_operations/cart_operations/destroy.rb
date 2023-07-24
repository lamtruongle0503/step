# frozen_string_literal: true

class Api::EcommerceOperations::CartOperations::Destroy < ApplicationOperation
  attr_reader :order_product

  def initialize(actor, params)
    super
    @order_product = OrderProduct.find(params[:id])
  end

  def call
    ActiveRecord::Base.transaction do
      # update_remaining_product!(order)
      order_product.destroy!
      destroy_order!(order_product)
    end
  end

  private

  def update_remaining_product!(order)
    product = order.product
    number = order.order_product.number
    product.increment!(:remaining_count, number)
  end

  def destroy_order!(order_product)
    order = order_product.order
    order.destroy! if order.order_products.size.zero?
  end
end

# frozen_string_literal: true

class Api::EcommerceOperations::CartOperations::Meta < ApplicationOperation
  attr_reader :user

  def initialize(actor, params)
    super
    @user = actor
  end

  def call
    order_carts = user.orders.waiting.includes(:agency,
                                               order_products: [product_size: :product])
    { number: number_order_cart(order_carts) }
  end

  private

  def number_order_cart(orders)
    number = 0
    orders.each do |obj|
      number += obj.order_products.pluck(:number).sum
    end
    number
  end
end

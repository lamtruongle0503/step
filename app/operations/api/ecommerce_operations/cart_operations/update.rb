# frozen_string_literal: true

class Api::EcommerceOperations::CartOperations::Update < ApplicationOperation
  attr_reader :order, :order_product

  def initialize(actor, params)
    super
    @order = Order.find(params[:id])
  end

  def call
    EcommerceContracts::OrderProductContracts::Update.new(order_product_params.merge(order: order,
                                                                                     user:  actor)).valid!
    @order_product = OrderProduct.find(params[:order_product_id])
    ActiveRecord::Base.transaction do
      update_number_order_product!(order_product)
      # update_remaining_product!(order_product)
    end
    order
  end

  # def update_remaining_product!(order_product)
  #   order_product.product.decrement!(:remaining_count, params[:number])
  # end

  def update_number_order_product!(order_product)
    if params[:number].to_i.zero?
      order_product.destroy!
    else
      order_product.update!(number: params[:number])
    end
  end

  def order_product_params
    params.permit(:order_product_id, :number)
  end
end

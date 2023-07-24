# frozen_string_literal: true

class Admin::UserOperations::OrderOperations::Index < ApplicationOperation
  attr_reader :user

  def initialize(actor, params)
    super
    @user = User.find(params[:id])
  end

  def call
    user.orders.where.not(order_status: Order::DRAFT)
        .includes(:delivery, :payment, order_products: :product_size)
        .page(params[:page])
  end
end

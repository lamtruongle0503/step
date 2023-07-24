# frozen_string_literal: true

class Admin::EcommerceOperations::OrderOperations::Index < ApplicationOperation
  def call
    authorize nil, Ecommerces::OrderPolicy

    @q = Order.includes(:user, :delivery, :payment, order_products: :product_size)
              .without_awaiting
              .ransack(params[:q])
    @orders = @q.result(distinct: true).order(updated_at: :desc).page(params[:page])
  end
end

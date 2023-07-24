# frozen_string_literal: true

class Api::EcommerceOperations::OrderOperations::Index < ApplicationOperation
  attr_reader :user

  def call
    actor.orders.includes(
      :agency, :payment, :delivery, order_info: :address, order_products: :order_log
    ).without_awaiting.order(checkout_date: :desc, updated_at: :desc, created_at: :desc)
         .page(params[:page])
  end
end

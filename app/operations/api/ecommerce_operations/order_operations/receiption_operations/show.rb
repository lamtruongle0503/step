# frozen_string_literal: true

class Api::EcommerceOperations::OrderOperations::ReceiptionOperations::Show < ApplicationOperation
  def call
    actor.orders.includes(:product_sizes,
                          order_products: [product: %i[coupon assets delivery_time_settings]])
         .find_by!(id: params[:order_id], order_status: Order::DONE)
  end
end

# frozen_string_literal: true

class Api::EcommerceOperations::OrderOperations::ReceiptionOperations::Download < ApplicationOperation
  def call
    order = actor.orders.includes(:product_sizes,
                                  order_products: [product: %i[coupon assets delivery_time_settings]])
                 .find_by!(id: params[:order_id], order_status: Order::DONE)

    EcommercesReceiption.new(order).to_pdf
  end
end

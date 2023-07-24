# frozen_string_literal: true

class Admin::UserOperations::HistoryOperations::Index < ApplicationOperation
  def call
    User.includes(orders: [:payment, :delivery, { order_products: :order_log }],
                  tour_orders: :tour_order_log, hotel_orders: :hotel).find(params[:id])
  end
end

# frozen_string_literal: true

require 'csv'

class Admin::EcommerceOperations::OrderOperations::DownloadOperations::Create < ApplicationOperation
  def call
    generate_csv
  end

  private

  def orders
    @q = Order.includes(:user, :payment, order_products: [product_size: :product])
              .without_awaiting
              .ransack(params[:q])
    @q.result(distinct: true).order(updated_at: :desc)
  end

  def generate_csv
    CSV.generate do |csv|
      csv << I18n.t(:orders, scope: [:headers])
      orders.each do |record|
        csv << [record.code, format_buyer(record.user), record.user.furigana, product_name(record),
                record.purchased_amount&.to_i, format_checkout_date(record.checkout_date),
                format_payment_method(record.payment&.code), format_payment_status(record.payment_status),
                format_delivery_status(record), format_order_status(record.order_status)]
      end
    end
  end
end

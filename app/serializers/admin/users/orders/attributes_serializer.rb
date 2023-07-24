# frozen_string_literal: true

class Admin::Users::Orders::AttributesSerializer < ApplicationSerializer
  attributes :id, :code, :purchased_amount, :delivery_amount, :delivery_status, :payment_status,
             :order_status, :checkout_date, :delivery_code, :full_name, :full_name_furigana,
             :product_name

  belongs_to :delivery, serializer: Admin::Deliveries::IndexSerializer
  belongs_to :payment, serializer: Admin::Payments::IndexSerializer

  def full_name
    object.user.full_name
  end

  def full_name_furigana
    object.user.furigana
  end

  def product_name
    object.order_products.map do |order_product|
      next unless order_product.order_log

      JSON.parse(order_product.order_log.product)['name']
    end.uniq.compact_blank
  end

  def purchased_amount
    object.purchased_amount&.to_i
  end

  def delivery_amount
    object.delivery_amount&.to_i
  end
end

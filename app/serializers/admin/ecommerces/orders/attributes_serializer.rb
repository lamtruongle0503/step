# frozen_string_literal: true

class Admin::Ecommerces::Orders::AttributesSerializer < ApplicationSerializer
  attributes :id, :order_status, :payment_status, :delivery_status, :purchased_amount, :delivery_amount,
             :created_at, :checkout_date, :code, :delivered_date, :received_point, :coupon_amount,
             :used_point, :received_bonus_point, :delivery_charges_fee

  attribute :product_name
  belongs_to :delivery, serializer: Admin::Deliveries::IndexSerializer
  belongs_to :payment, serializer: Admin::Payments::IndexSerializer

  def product_name
    object.order_products.map do |order_product|
      order_product.product_size.product.name
    end.uniq
  end

  def purchased_amount
    object.purchased_amount&.round
  end

  def delivery_amount
    object.delivery_amount&.round
  end
end

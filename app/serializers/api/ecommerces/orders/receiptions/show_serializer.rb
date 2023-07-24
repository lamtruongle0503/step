# frozen_string_literal: true

class Api::Ecommerces::Orders::Receiptions::ShowSerializer < ApplicationSerializer
  attributes :date_invoice, :purchased_amount,
             :delivery_amount, :total_purchased, :delivery_status,
             :checkout_date, :quantity,
             :email_receiption, :used_point,
             :coupon_amount, :received_point, :delivery_name,
             :received_bonus_point, :payment_name, :delivery_charges_fee
  has_many :order_products, serializer: Api::Ecommerces::Orders::OrderProducts::MetaSerializer
  has_one :order_info, serializer: Api::Ecommerces::OrderInfos::AttributesSerializer

  def date_invoice
    Date.today.as_json
  end

  def quantity
    object.order_products.sum(&:number)
  end

  def purchased_amount
    object.purchased_amount.to_i
  end

  def used_point
    object.used_point.to_i
  end

  def delivery_amount
    object.delivery_amount.to_i
  end

  def total_purchased
    object.purchased_amount.to_f.to_i + object.delivery_amount.to_f.to_i
  end

  def email_receiption
    object.user.email || object&.order_info&.email_receiption
  end

  def coupon_amount
    return 0 unless object.coupon

    object.coupon.price
  end

  def delivery_name
    object.delivery.name
  end

  def payment_name
    object.payment.name
  end
end

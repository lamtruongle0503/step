# frozen_string_literal: true

class Api::Ecommerces::Orders::ShowSerializer < ApplicationSerializer
  attr_reader :actor

  def initialize(object, options = {})
    super
    @actor = options[:actor]
  end

  attributes :id, :order_status, :point_amount, :coupon_amount,
             :payment_status, :payment_type, :delivery_status, :purchased_amount,
             :created_at, :checkout_date, :delivery_amount, :used_point, :delivery_free_amount

  has_many :order_products, serializer: Api::Ecommerces::Orders::OrderProducts::MetaSerializer
  belongs_to :agency, serializer: Api::Ecommerces::Orders::Agencies::MetaSerializer

  def point_amount
    return 0 unless object.point_use

    object.point_use.used_point.to_i
  end

  def coupon_amount
    return 0 unless object.coupon

    object.coupon.price.to_i
  end

  def purchased_amount
    object.purchased_amount.to_f.to_i
  end

  def delivery_amount
    object.delivery_amount.to_f.to_i
  end

  def used_point
    object.used_point.to_f.to_i
  end
end

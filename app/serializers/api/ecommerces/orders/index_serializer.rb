# frozen_string_literal: true

class Api::Ecommerces::Orders::IndexSerializer < ApplicationSerializer
  attr_reader :actor

  def initialize(object, options = {})
    super
    @actor = options[:actor]
  end

  attributes :id, :order_status, :payment_status, :delivery_status, :purchased_amount, :delivery_amount,
             :created_at, :checkout_date, :code, :delivered_date, :received_point, :coupon_amount,
             :used_point, :received_bonus_point, :delivery_charges_fee, :delivery_free_amount
  has_many :order_products, serializer: Api::Ecommerces::Orders::OrderProducts::ShowSerializer
  belongs_to :agency, serializer: Api::Ecommerces::Orders::Agencies::MetaSerializer
  belongs_to :payment, serializer: Api::Ecommerces::Payments::AttributesSerializer
  belongs_to :delivery, serializer: Api::Ecommerces::Deliveries::AttributesSerializer
  belongs_to :order_info, serializer: Api::Ecommerces::OrderInfos::AttributesSerializer

  def purchased_amount
    object.purchased_amount.to_f.to_i
  end

  def delivery_amount
    object.delivery_amount.to_f.to_i
  end

  def received_point
    object.received_point.to_f.to_i
  end

  def coupon_amount
    object.coupon_amount.to_f.to_i
  end

  def used_point
    object.used_point.to_f.to_i
  end

  def delivery_free_amount
    object.delivery_free_amount.to_i
  end
end

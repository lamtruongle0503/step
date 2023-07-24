# frozen_string_literal: true

class EcommerceContracts::CartContracts::Base < ApplicationContract
  attribute :code,                      String
  attribute :user_id,                   Integer
  attribute :name,                      String
  attribute :purchased_amount,          Float
  attribute :delivery_amount,           Float
  attribute :payment_status,            Integer
  attribute :payment_type,              Integer
  attribute :delivery_status,           Integer
  attribute :order_products_attributes, Array
  attribute :order_info_attributes,     Hash
  attribute :order_status,              String

  validates :order_status, inclusion: { in: Order.order_statuses }, if: -> { order_status }
end

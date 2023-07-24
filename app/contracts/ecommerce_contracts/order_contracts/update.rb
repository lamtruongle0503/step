# frozen_string_literal: true

class EcommerceContracts::OrderContracts::Update < ApplicationContract
  attribute :record,          Order
  attribute :order_status,    String
  attribute :payment_status,  String
  attribute :delivery_status, String
  attribute :payment_id,      String
  attribute :delivery_code,   String

  validates :payment_id, existence: Payment.name, if: -> { payment_id }
  validates :order_status, inclusion: { in: Order.order_statuses }, if: -> { order_status }
  validates :delivery_status, inclusion: { in: Order.delivery_statuses }, if: -> { delivery_status }
  validates :payment_status, inclusion: { in: Order.payment_statuses }, if: -> { payment_status }
  validates :delivery_code, uniqueness: { model: Order }, if: -> { valid_code? }

  def valid_code?
    delivery_code.present? && delivery_code != record.delivery_code
  end
end

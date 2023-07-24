# frozen_string_literal: true

class EcommerceContracts::OrderContracts::Base < ApplicationContract
  attribute :code,                      String
  attribute :user_id,                   Integer
  attribute :name,                      String
  attribute :purchased_amount,          Float
  attribute :delivery_amount,           Float
  attribute :payment_status,            Integer
  attribute :payment_type,              Integer
  attribute :delivery_status,           Integer
  attribute :order_product_attributes,  Hash
  attribute :order_info_attributes,     Hash
  attribute :order_status,              String
  attribute :payment_status,            String
  attribute :delivery_status,           String
  attribute :user,                      User
  attribute :is_apply_point,            Boolean
  attribute :payment_type,              String
  attribute :coupon_id,                 Integer

  validates :is_apply_point, inclusion: { in: [true, false] }
  validates :payment_type, presence: true, inclusion: { in: Order.payment_types }
  validates :code, uniqueness: { model: Order }
  validates :order_status, inclusion: { in: Order.order_statuses }, if: -> { order_status }
  validates :delivery_status, inclusion: { in: Order.delivery_statuses }, if: -> { delivery_status }
  validates :payment_status, inclusion: { in: Order.payment_statuses }, if: -> { payment_status }
  validates :coupon_id, existence: Coupon.name, if: -> { coupon_id.present? }

  validate :must_has_credit_card, if: -> { payment_type == Order::CREDIT_CARD }

  def must_has_credit_card
    customer_id = user.credit&.customer_id
    return errors.add :credit, I18n.t(:not_registered, scope: :credit) if customer_id.blank?

    list_cards = StripeService.get_list_credit_card(customer_id)
    errors.add :credit, I18n.t('orders.must_has_credit_card') if list_cards.blank?
  end
end

# frozen_string_literal: true

class EcommerceContracts::OrderContracts::CheckoutContracts::Create < ApplicationContract
  attribute :record,          Order
  attribute :user,            User
  attribute :code,            String
  attribute :is_apply_point,  Boolean
  attribute :payment_id,      Integer
  attribute :coupon_id,       Integer
  attribute :delivery_id,     Integer

  validates :payment_id, presence: true, existence: Payment.name
  validates :delivery_id, presence: true, existence: Delivery.name

  validates :code, uniqueness: { model: Order }
  validates :is_apply_point, inclusion: { in: [true, false] }
  validates :coupon_id, existence: Coupon.name, if: -> { coupon_id.present? }

  validate :status_must_waiting
  validate :must_has_credit_card, if: -> { use_credit? }
  validate :remain_product_must_greater_than_zero
  validate :product_must_be_show

  def status_must_waiting
    current_status = record.order_status
    return if [Order::WAITING, Order::DRAFT].include?(current_status)

    errors.add :order_status,
               I18n.t('orders.must_be_waiting')
  end

  def must_has_credit_card
    customer_id = user.credit&.customer_id
    return errors.add :credit, I18n.t(:not_registered, scope: :credit) if customer_id.blank?

    list_cards = StripeService.get_list_credit_card(customer_id)
    errors.add :credit, I18n.t('orders.must_has_credit_card') if list_cards.blank?
  end

  def use_credit?
    Payment.find_by!(code: Order::CREDIT_CARD).id == payment_id
  end

  def remain_product_must_greater_than_zero
    record.order_products.each do |order_product|
      product_size = order_product.product_size
      next unless product_size.is_limit

      next if product_size.remaining_count.to_i - order_product.number.to_i >= 0

      errors.add(:number,
                 I18n.t('order_products.remain_product_must_greater_than_zero'))
    end
  end

  def product_must_be_show
    record.products.each do |product|
      next if product.is_show

      errors.add(:product,
                 I18n.t('carts.product_must_be_show'))
    end
  end
end

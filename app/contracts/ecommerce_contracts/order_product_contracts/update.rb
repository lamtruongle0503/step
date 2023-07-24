# frozen_string_literal: true

class EcommerceContracts::OrderProductContracts::Update < ApplicationContract
  attribute :order,            Order
  attribute :number,           Integer
  attribute :order_product_id, Integer
  attribute :user,             User

  validates :number, presence: true

  validate :order_product_must_be_in_order, :remain_product_must_greater_than_zero

  def order_product_must_be_in_order
    return if order.order_products.pluck(:id).include?(order_product_id)

    errors.add(:order_product, I18n.t('order_products.must_be_in_order'))
  end

  def remain_product_must_greater_than_zero
    order_product = OrderProduct.find(order_product_id)
    product_size  = order_product.product_size
    return unless product_size.is_limit

    remaining = product_size.remaining_count
    return if remaining - number >= 0

    errors.add(:number,
               I18n.t('order_products.remain_product_must_greater_than_zero'))
  end
end

# frozen_string_literal: true

class EcommerceContracts::OrderProductContracts::Base < ApplicationContract
  attribute :order_id,         Integer
  attribute :price,            Float
  attribute :number,           Integer
  attribute :purchased_amount, Float
  attribute :product_size_id,  Integer
  attribute :user,             User

  validates :product_size_id, presence: true, existence: ProductSize.name

  validate :remain_product_must_greater_than_zero
  validate :product_must_be_show

  def remain_product_must_greater_than_zero
    product_size = ProductSize.find(product_size_id)
    return if !product_size.is_limit || (remaining_limit(product_size).to_i - number.to_i) >= 0

    errors.add(:number,
               I18n.t('order_products.remain_product_must_greater_than_zero'))
  end

  def product_must_be_show
    product = ProductSize.find(product_size_id).product
    return if product.is_show

    errors.add(:product, I18n.t('carts.product_must_be_show'))
  end

  def remaining_limit(product_size)
    return unless product_size.is_limit

    product_size.remaining_count - count_remaining_product(user.id, product_size.id)
  end
end

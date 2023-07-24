# frozen_string_literal: true

class EcommerceContracts::ProductContracts::CouponContracts::Create <
      EcommerceContracts::ProductContracts::CouponContracts::Base
  attribute :product, Product

  validate :price_must_less_than_or_equal_product_size

  def price_must_less_than_or_equal_product_size
    product.product_sizes.each do |product_size|
      next if product_size.price > price

      errors.add :price, I18n.t('orders.coupons.must_less_than_or_equal_product_price')
    end
  end
end

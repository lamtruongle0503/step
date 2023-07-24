# frozen_string_literal: true

class EcommerceContracts::OrderContracts::Create < EcommerceContracts::OrderContracts::Base
  validate :order_product, :order_info

  def order_product
    EcommerceContracts::OrderProductContracts::Create.new(order_product_attributes).valid!
  end

  def order_info
    product = ProductSize.find(order_product_attributes['product_size_id']).product
    EcommerceContracts::OrderInfoContracts::Create.new(order_info_attributes
                                                      .merge(product: product, user: user)).valid!
  end
end

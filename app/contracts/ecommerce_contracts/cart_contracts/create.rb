# frozen_string_literal: true

class EcommerceContracts::CartContracts::Create < EcommerceContracts::CartContracts::Base
  attribute :user, User
  validate :order_products

  def order_products
    order_products_attributes.each do |order_product|
      EcommerceContracts::OrderProductContracts::Create.new(order_product.merge(user: user)).valid!
    end
  end
end

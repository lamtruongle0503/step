# frozen_string_literal: true

class Api::Ecommerces::Coupons::Users::IndexSerializer < Api::Coupons::AttributeSerializer
  attributes :product_name, :category_name

  def product_name
    return unless object.products.present?

    object.products.first.name
  end

  def category_name
    return unless object.products.present?

    object.products.first.category.name
  end
end

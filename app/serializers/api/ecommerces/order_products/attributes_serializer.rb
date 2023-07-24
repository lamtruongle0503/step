# frozen_string_literal: true

class Api::Ecommerces::OrderProducts::AttributesSerializer < ApplicationSerializer
  attributes :id, :price, :number, :purchased_amount, :color

  attribute :product_size
  attribute :product

  def product_size
    Api::Ecommerces::ProductSizes::AttributesSerializer.new(object.product_size).as_json
  end

  def product
    Api::Ecommerces::Products::ShowSerializer.new(object.product_size.product).as_json
  end

  def price
    object.price.to_i
  end
end

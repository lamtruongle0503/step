# frozen_string_literal: true

class Api::Ecommerces::Carts::AttributesSerializer < ApplicationSerializer
  attribute :orders

  def orders
    Api::Ecommerces::Orders::AttributesSerializer.new(object).as_json
  end
end

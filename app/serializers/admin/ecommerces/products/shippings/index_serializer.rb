# frozen_string_literal: true

class Admin::Ecommerces::Products::Shippings::IndexSerializer < ApplicationSerializer
  attributes :delivery_amount

  def delivery_amount
    object[:delivery_amount]
  end
end

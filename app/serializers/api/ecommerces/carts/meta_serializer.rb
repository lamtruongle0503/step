# frozen_string_literal: true

class Api::Ecommerces::Carts::MetaSerializer < ApplicationSerializer
  attributes :number

  def number
    object[:number]
  end
end

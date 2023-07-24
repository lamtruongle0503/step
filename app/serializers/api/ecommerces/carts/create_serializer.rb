# frozen_string_literal: true

class Api::Ecommerces::Carts::CreateSerializer < ApplicationSerializer
  attribute :id

  def id
    return unless object

    object[:id]
  end
end

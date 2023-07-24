# frozen_string_literal: true

class Api::Ecommerces::Categories::IndexSerializer < ApplicationSerializer
  attributes :id, :name, :ranking

  has_one :asset, serializer: Assets::AttributesSerializer
end

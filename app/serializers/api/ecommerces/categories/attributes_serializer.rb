# frozen_string_literal: true

class Api::Ecommerces::Categories::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :ranking

  has_one :asset, serializer: Assets::AttributesSerializer
end

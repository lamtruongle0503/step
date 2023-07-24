# frozen_string_literal: true

class Admin::Ecommerces::Categories::AttributesSerializer < ApplicationSerializer
  attributes :id, :code, :name, :ranking

  has_one :asset, serializer: Assets::AttributesSerializer
end

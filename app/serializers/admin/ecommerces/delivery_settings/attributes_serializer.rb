# frozen_string_literal: true

class Admin::Ecommerces::DeliverySettings::AttributesSerializer < ApplicationSerializer
  attributes :id, :vendor, :memo, :other, :price, :is_free
end

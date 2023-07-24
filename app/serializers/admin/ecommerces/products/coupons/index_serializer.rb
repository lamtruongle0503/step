# frozen_string_literal: true

class Admin::Ecommerces::Products::Coupons::IndexSerializer < ApplicationSerializer
  attributes :id, :name, :code
  has_one :coupon, serializer: Admin::Coupons::AttributesSerializer
end

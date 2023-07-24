# frozen_string_literal: true

class Admin::Ecommerces::Products::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :code, :is_delivery_free, :is_show, :is_color, :is_discount, :is_product_size,
             :delivery_charges_fee, :is_delivery_charges
  belongs_to :category, serializer: Admin::Ecommerces::Categories::AttributesSerializer
end

# frozen_string_literal: true

class Admin::Ecommerces::ProductSizes::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :price, :remaining_count, :is_limit,
             :is_product_size, :option_size_name, :is_color_name,
             :option_color_name, :color_name
end

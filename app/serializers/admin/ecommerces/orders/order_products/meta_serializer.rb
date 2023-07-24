# frozen_string_literal: true

class Admin::Ecommerces::Orders::OrderProducts::MetaSerializer < ApplicationSerializer
  attributes :id, :number, :discount, :is_discount, :product, :size_name, :color_name, :option_color_name,
             :is_limit, :is_product_size, :option_size_name, :is_color_name

  def product
    Admin::Ecommerces::Orders::Products::MetaSerializer.new(object.product).as_json
  end

  def price
    object.product_size.price.to_i
  end

  def is_discount # rubocop:disable  Naming/PredicateName
    object.product.is_discount
  end

  def size_name
    object.product_size.name
  end

  def color_name
    object.product_size.color_name
  end

  def option_color_name
    object.product_size.option_color_name
  end

  def is_limit # rubocop:disable  Naming/PredicateName
    object.product_size.is_limit
  end

  def is_product_size # rubocop:disable  Naming/PredicateName
    object.product_size.is_product_size
  end

  def option_size_name
    object.product_size.option_size_name
  end

  def is_color_name # rubocop:disable  Naming/PredicateName
    object.product_size.is_color_name
  end
end

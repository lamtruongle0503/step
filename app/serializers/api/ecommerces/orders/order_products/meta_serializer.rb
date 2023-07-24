# frozen_string_literal: true

class Api::Ecommerces::Orders::OrderProducts::MetaSerializer < ApplicationSerializer
  attr_reader :actor, :product_order

  def initialize(object, options = {})
    super
    @actor         = options[:actor]
    @product_order = object.product_size.product
  end

  attributes :id, :number, :discount, :color,
             :product, :price, :size_name, :remaining_limit, :remaining_count,
             :color_name, :option_color_name, :is_color_name, :is_limit, :is_product_size,
             :option_size_name

  def product
    Api::Ecommerces::Orders::Products::MetaSerializer.new(object.product, actor: actor).as_json
  end

  def price
    object.product_size.price.to_i
  end

  def size_name
    object.product_size.name
  end

  def discount
    product_order.discount
  end

  def is_discount # rubocop:disable  Naming/PredicateName
    product_order.is_discount
  end

  def remaining_count
    return unless object.product_size.is_limit

    object.product_size.remaining_count - count_remaining_product(actor.id, object.product_size.id)
  end

  def remaining_limit
    return unless object.product_size.is_limit

    object.product_size.remaining_count - count_remaining_product(actor.id, object.product_size.id)
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

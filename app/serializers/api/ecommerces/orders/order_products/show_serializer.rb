# frozen_string_literal: true

class Api::Ecommerces::Orders::OrderProducts::ShowSerializer < ApplicationSerializer
  attributes :id, :number, :product, :price, :size_name, :discount, :is_discount,
             :remaining_limit, :color_name, :is_color_name, :option_color_name, :is_limit,
             :is_product_size, :option_size_name

  attr_reader :actor

  def initialize(object, options = {})
    super
    @actor = options[:actor]
  end

  def product
    return unless object.order_log

    Api::Ecommerces::Orders::ProductLogs::MetaSerializer.new(JSON.parse(object.order_log.product)
                                                                 .merge!('is_show' => object.product.is_show),
                                                             actor: actor).as_json
  end

  def price
    return unless object.order_log

    JSON.parse(object.order_log.product_size)['price']
  end

  def size_name
    return unless object.order_log

    JSON.parse(object.order_log.product_size)['name']
  end

  def discount
    return unless object.order_log

    JSON.parse(object.order_log.product)['discount']
  end

  def is_discount # rubocop:disable  Naming/PredicateName
    return unless object.order_log

    JSON.parse(object.order_log.product)['is_discount']
  end

  def remaining_limit
    return unless object.order_log

    product_size = JSON.parse(object.order_log.product_size)
    return unless product_size['is_limit']

    product_size['remaining_count'] - count_remaining_product(actor.id, product_size['id'])
  end

  def remaining_count
    return unless object.order_log

    product_size = JSON.parse(object.order_log.product_size)
    return unless product_size['is_limit']

    product_size['remaining_count']
  end

  def color_name
    return unless object.order_log

    product_size = JSON.parse(object.order_log.product_size)
    return unless product_size['color_name']

    product_size['color_name']
  end

  def option_color_name
    return unless object.order_log

    product_size = JSON.parse(object.order_log.product_size)
    return unless product_size['option_color_name']

    product_size['option_color_name']
  end

  def is_limit # rubocop:disable  Naming/PredicateName
    return unless object.order_log

    product_size = JSON.parse(object.order_log.product_size)
    return unless product_size['is_limit']

    product_size['is_limit']
  end

  def is_product_size # rubocop:disable  Naming/PredicateName
    return unless object.order_log

    product_size = JSON.parse(object.order_log.product_size)
    return unless product_size['is_product_size']

    product_size['is_product_size']
  end

  def option_size_name
    return unless object.order_log

    product_size = JSON.parse(object.order_log.product_size)
    return unless product_size['option_size_name']

    product_size['option_size_name']
  end

  def is_color_name # rubocop:disable  Naming/PredicateName
    return unless object.order_log

    product_size = JSON.parse(object.order_log.product_size)
    return unless product_size['is_color_name']

    product_size['is_color_name']
  end
end

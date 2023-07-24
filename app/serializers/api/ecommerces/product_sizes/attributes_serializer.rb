# frozen_string_literal: true

class Api::Ecommerces::ProductSizes::AttributesSerializer < ApplicationSerializer
  attr_reader :actor

  attributes :id, :name, :price, :remaining_count, :is_limit, :remaining_limit,
             :is_product_size, :option_size_name,
             :is_color_name, :option_color_name, :color_name

  def initialize(object, options = {})
    super
    @actor = options[:actor]
  end

  def price
    object.price.to_i
  end

  def remaining_count
    return unless object.is_limit

    object.remaining_count
  end

  def remaining_limit
    return unless object.is_limit

    object.remaining_count - count_remaining_product(actor&.id, object.id)
  end
end

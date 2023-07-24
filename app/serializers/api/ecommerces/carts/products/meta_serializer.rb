# frozen_string_literal: true

class Api::Ecommerces::Carts::Products::MetaSerializer < ApplicationSerializer
  attributes :id, :name, :image_preview, :remaining_count, :is_limit, :tax,
             :point_bonus, :point_start_date, :point_end_date, :is_discount,
             :is_color, :is_product_size, :avatar, :option_name, :option_color_name,
             :is_delivery_charges, :delivery_charges_fee, :is_show, :remaining_limit

  attr_reader :actor

  def initialize(object, options = {})
    super
    @actor = options[:actor]
  end

  def image_preview
    object.assets.select { |image| image.type == Asset::IMAGE_PREVIEWS }.first
  end

  def avatar
    avatar = object.assets.select { |image| image.type == Asset::PRODUCT_AVATAR }.first
    Assets::AttributesSerializer.new(avatar).as_json if avatar
  end

  def remaining_count
    return unless object.is_limit

    object.remaining_count
  end

  def remaining_limit
    return unless object.is_limit

    object.remaining_count - count_remaining_product(actor.id, object.id)
  end
end

# frozen_string_literal: true

class Api::Ecommerces::Orders::ProductLogs::MetaSerializer < ApplicationSerializer
  attributes :id, :name, :image_preview, :remaining_count, :is_limit, :tax,
             :point_bonus, :point_start_date, :point_end_date, :is_discount,
             :is_color, :is_product_size, :avatar, :option_name, :option_color_name,
             :is_delivery_charges, :delivery_charges_fee, :is_show, :remaining_limit

  attr_reader :actor, :product

  def initialize(object, options = {})
    super
    @actor = options[:actor]
    @product = Product.with_deleted.find(object['id'])
  end

  def id
    object['id']
  end

  def name
    object['name']
  end

  def image_preview
    preview = product.assets.with_deleted.select { |image| image.type == Asset::IMAGE_PREVIEWS }.first
    Assets::AttributesSerializer.new(preview).as_json if preview
  end

  def avatar
    avatar = product.assets.with_deleted.select { |image| image.type == Asset::PRODUCT_AVATAR }.first
    Assets::AttributesSerializer.new(avatar).as_json if avatar
  end

  def remaining_count
    return unless object['is_limit']

    object['remaining_count']
  end

  def is_limit # rubocop:disable Naming/PredicateName
    object['is_limit']
  end

  def tax
    object['tax']
  end

  def point_bonus
    object['point_bonus']
  end

  def point_start_date
    object['point_start_date']
  end

  def point_end_date
    object['point_end_date']
  end

  def is_discount # rubocop:disable Naming/PredicateName
    object['is_discount']
  end

  def is_color # rubocop:disable Naming/PredicateName
    object['is_color']
  end

  def is_product_size # rubocop:disable Naming/PredicateName
    object['is_product_size']
  end

  def option_name
    object['option_name']
  end

  def is_delivery_charges # rubocop:disable Naming/PredicateName
    object['is_delivery_charges']
  end

  def delivery_charges_fee
    object['delivery_charges_fee']
  end

  def is_show # rubocop:disable Naming/PredicateName
    object['is_show']
  end

  def remaining_limit
    return unless object['is_limit']

    object['remaining_count'] - count_remaining_product(actor.id, object['id'])
  end

  def option_color_name
    object['option_color_name']
  end
end

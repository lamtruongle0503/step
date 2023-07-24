# frozen_string_literal: true

class Api::Users::Points::AttributesSerializer < ApplicationSerializer
  attributes :id, :used_point, :received_point, :created_at, :title, :module_type, :start_date, :end_date,
             :delivered_date, :avatar, :received_date

  has_many :image_backgrounds, serializer: Assets::AttributesSerializer

  def title
    case object.module_type
    when Admin.name
      object.title
    when Order.name
      object.module&.code
    else
      object.module&.order_no
    end
  end

  def image_backgrounds
    return if object.module_type == Admin.name || object.module.nil?

    case object.module_type
    when Order.name
      object.module.products.first.assets.select { |image| image.type == Asset::IMAGE_BACKGROUNDS }
    when Hotel::Order.name
      object.module.hotel.assets.select { |image| image.type == Asset::IMAGE_BACKGROUNDS }
    else
      object.module.tour.assets.select { |image| image.type == Asset::IMAGE_BACKGROUNDS }
    end
  end

  def avatar
    return if object.module_type == Admin.name || object.module.nil?

    case object.module_type
    when Order.name
      object.module.products.first.assets.select { |image| image.type == Asset::PRODUCT_AVATAR }
    when Hotel::Order.name
      object.module.hotel.assets.select { |image| image.type == Asset::THUMBNAIL }
    else
      object.module.tour.assets.select { |image| image.type == Asset::THUMBNAIL }
    end
  end

  def module_type
    object.type_point
  end

  def delivered_date
    return unless object.module
    return if object.module_type == Admin.name

    object.module.updated_at.to_date
  end

  def received_point
    return unless object.received_point

    object.received_point.to_i
  end

  def used_point
    return unless object.used_point

    object.used_point.to_i
  end
end

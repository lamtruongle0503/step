# frozen_string_literal: true

class Api::Notifications::AttributesSerializer < ApplicationSerializer
  attributes :id, :title, :description, :created_at, :module_type, :module_id, :is_point_bonus,
             :is_received_point, :is_expried
  attribute :module
  has_one :asset, serializer: Assets::AttributesSerializer

  def module
    case object.module_type
    when Tour.name
      Api::Tours::AttributeSerializer.new(object.module).as_json
    when Coupon.name
      Api::Coupons::AttributeSerializer.new(object.module).as_json
    end
  end

  def is_point_bonus # rubocop:disable Naming/PredicateName
    object.module_type == PointUsage.name
  end

  def is_received_point # rubocop:disable Naming/PredicateName
    return false unless object.point_usage.present?
    return true if object.point_usage.exp_start_date > Date.today

    object.point_usage.is_received
  end

  def is_expried # rubocop:disable Naming/PredicateName
    return false unless object.module_type == PointUsage.name
    return true unless object.point_usage.present?

    point_bonuses = object.point_usage
    if Time.current.between?(point_bonuses.start_date,
                             point_bonuses.end_date) || Time.current < point_bonuses.start_date
      return false
    end

    true
  end
end

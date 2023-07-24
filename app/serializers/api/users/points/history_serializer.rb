# frozen_string_literal: true

class Api::Users::Points::HistorySerializer < ApplicationSerializer
  attributes :user_point, :bonus_point, :used_point, :received_point

  def user_point
    object[:user_point].to_i
  end

  def bonus_point
    object[:bonus_point].to_i
  end

  def used_point
    object[:histories].map do |obj|
      next if obj.used_point.blank?
      next if obj.used_point <= 0

      Api::Users::Points::AttributesSerializer.new(obj).as_json
    end.compact
  end

  def received_point
    object[:histories].map do |obj|
      next if obj.received_point.blank?
      next if obj.module_type == Admin.name && !obj.is_received
      next unless obj.is_received
      next if obj.received_point <= 0

      Api::Users::Points::AttributesSerializer.new(obj).as_json
    end.compact
  end
end

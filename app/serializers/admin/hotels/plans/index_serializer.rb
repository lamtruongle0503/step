# frozen_string_literal: true

class Admin::Hotels::Plans::IndexSerializer < Admin::Hotels::Plans::AttributesSerializer
  attributes :cxl_management_name, :room_name, :option_name

  def cxl_management_name
    object.hotel_cancellation_policy.cxl_management_name
  end

  def room_name
    object.hotel_rooms.map(&:name).uniq.join(',')
  end

  def option_name
    Hotel::Option.where(id: object.option_ids).map(&:name).uniq.join(',')
  end
end

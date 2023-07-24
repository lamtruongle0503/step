# frozen_string_literal: true

class Api::Hotels::Rooms::Meta::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :room_type, :square_meter_max, :capacity, :room_settings, :square_meter_min,
             :description, :capacity

  def initialize(object, options = {})
    super
    @plan = options[:plan]
    @check_in_date = options[:check_in_date].to_date
  end

  def room_settings # rubocop:disable Metrics/PerceivedComplexity
    hotel_room_settings = object.hotel_room_settings.where(hotel_plan_id: @plan.id,
                                                           status:        Hotel::RoomSetting::OPEN)
    return [] unless hotel_room_settings.present?

    dates = hotel_room_settings.map(&:date).sort
    date = if dates.include?(@check_in_date)
             @check_in_date
           else
             @check_in_date > dates.last ? @check_in_date : dates.first
           end
    hotel_room_setting = object.hotel_room_settings.where(date:          date...dates.last,
                                                          hotel_plan_id: @plan.id).detect do |room_setting|
      !room_setting.remain_room.zero?
    end
    hotel_room_setting ||= object.hotel_room_settings.where(date:          date...dates.last,
                                                            hotel_plan_id: @plan.id).first
    return [] unless hotel_room_setting

    [Api::Hotels::RoomSettings::AttributesSerializer.new(hotel_room_setting).as_json]
  end
end

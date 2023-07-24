# frozen_string_literal: true

class Api::Hotels::Rooms::ShowSerializer < ApplicationSerializer
  attributes :hotel_plan, :hotel_room, :room_settings

  def hotel_plan
    Api::Hotels::Plans::ShowSerializer.new(object[:hotel_plan]).as_json
  end

  def hotel_room
    Api::Hotels::Rooms::AttributesSerializer.new(object[:hotel_room]).as_json
  end

  def room_settings
    object[:hotel_room_setting].map do |obj|
      Api::Hotels::RoomSettings::AttributesSerializer.new(obj).as_json
    end
  end
end

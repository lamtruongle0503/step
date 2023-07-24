# frozen_string_literal: true

class Api::Hotels::RoomSettings::IndexSerializer < Api::Hotels::RoomSettings::AttributesSerializer
  belongs_to :hotel_room, serializer: Api::Hotels::Rooms::IndexSerializer
end

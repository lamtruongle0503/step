# frozen_string_literal: true

class Api::Hotels::Plans::RoomSerializer < ApplicationSerializer
  attributes :name, :room_type, :square_meter_max, :square_meter_min, :capacity
end

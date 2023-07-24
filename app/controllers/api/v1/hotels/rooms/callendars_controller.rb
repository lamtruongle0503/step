# frozen_string_literal: true

class Api::V1::Hotels::Rooms::CallendarsController < ApiV1Controller
  def index
    callendar = Api::HotelOperations::RoomOperations::CallendarsOperations::Index.new(nil, params).call
    render json: callendar, each_serializer: Api::Hotels::RoomSettings::AttributesSerializer
  end
end

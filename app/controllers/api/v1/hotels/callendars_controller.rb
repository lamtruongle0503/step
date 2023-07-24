# frozen_string_literal: true

class Api::V1::Hotels::CallendarsController < ApiV1Controller
  def index
    callendars = Api::HotelOperations::CallendarOperations::Index.new(nil, params).call
    render json: callendars, each_serializer: Api::Hotels::RoomSettings::AttributesSerializer,
           root: 'hotels'
  end
end

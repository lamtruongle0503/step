# frozen_string_literal: true

class Api::V1::Hotels::RoomsController < ApiV1Controller
  def show
    hotel_room = Api::HotelOperations::RoomOperations::Show.new(nil, params).call
    render json: hotel_room, serializer: Api::Hotels::Rooms::ShowSerializer, root: 'hotel'
  end
end

# frozen_string_literal: true

class Admin::Hotels::Rooms::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    hotel_rooms = Admin::HotelOperations::RoomOperations::MetaOperations::Index.new(actor, params).call
    render json: hotel_rooms,
           each_serializer: Admin::Hotels::Rooms::IndexSerializer,
           root: 'data', adapter: :json
  end
end

# frozen_string_literal: true

class Admin::HotelOperations::RoomOperations::Show < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
  end

  def call
    authorize nil, Hotel::RoomPolicy

    @hotel_room = @hotel.hotel_rooms.find(params[:id])
  end
end

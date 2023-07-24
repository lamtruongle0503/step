# frozen_string_literal: true

class Admin::HotelOperations::RoomOperations::Index < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:id])
  end

  def call
    authorize nil, Hotel::RoomPolicy

    @q = @hotel.hotel_rooms.ransack(params[:q])
    @q.result(distinct: true)
  end
end

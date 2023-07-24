# frozen_string_literal: true

class Admin::HotelOperations::RoomOperations::Destroy < ApplicationOperation
  def call
    authorize nil, Hotel::RoomPolicy

    @hotel_room = Hotel::Room.find(params[:id])
    ActiveRecord::Base.transaction do
      @hotel_room.destroy!
    end
  end
end

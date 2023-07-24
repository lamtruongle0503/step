# frozen_string_literal: true

class Admin::HotelOperations::RoomOperations::MetaOperations::Index < ApplicationOperation
  def call
    Hotel.find(params[:hotel_id]).hotel_rooms.setting_show
  end
end

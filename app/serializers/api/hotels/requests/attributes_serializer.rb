# frozen_string_literal: true

class Api::Hotels::Requests::AttributesSerializer < ApplicationSerializer
  attributes :id, :request_no, :full_name, :phone_number, :email, :check_in, :check_out, :total_person,
             :total_room, :room_type, :hotel_name, :room_name

  def hotel_name
    object.hotel.name
  end

  def room_name
    object.hotel_room.name
  end
end

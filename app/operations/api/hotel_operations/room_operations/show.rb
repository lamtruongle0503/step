# frozen_string_literal: true

class Api::HotelOperations::RoomOperations::Show < ApplicationOperation
  attr_reader :hotel_plan, :hotel_room, :hotel_room_setting

  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
    @hotel_plan = @hotel.hotel_plans.find(params[:plan_id])
  end

  def call
    @hotel_room = @hotel_plan.hotel_rooms.find(params[:id])
    star_date = params[:date_check_in].to_date
    end_date = star_date + params[:to_night].to_i
    @hotel_room_setting = @hotel_plan.hotel_room_settings.where(date:          star_date..end_date,
                                                                hotel_room_id: params[:id],
                                                                status:        Hotel::RoomSetting::OPEN)

    { hotel_plan: hotel_plan, hotel_room: hotel_room, hotel_room_setting: hotel_room_setting }
  end
end

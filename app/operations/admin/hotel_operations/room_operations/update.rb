# frozen_string_literal: true

require 'hotel/room'
class Admin::HotelOperations::RoomOperations::Update < ApplicationOperation
  attr_reader :hotel_room

  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
    @hotel_room = @hotel.hotel_rooms.find(params[:id])
  end

  def call
    authorize nil, Hotel::RoomPolicy

    ActiveRecord::Base.transaction do
      update_hotel_room!
    end
  end

  private

  def update_hotel_room!
    HotelContracts::RoomContracts::Update.new(
      params_hotel_room.merge(hotel_allow_children: @hotel.allow_children),
    )
                                         .valid!
    hotel_room.update!(params_hotel_room)
    upload_image_hotel(hotel_room) if params[:file]
  end

  def params_hotel_room
    params.permit(:capacity, :description, :floor_plan, :is_show, :is_smoking, :management_name,
                  :name, :room_type, :setting_date, :square_meter_max, :square_meter_min, :total_floor_max,
                  :total_floor_min, :floor_type, :created_at, :updated_at, :hotel_id,
                  :number_children, :floor_number)
  end

  def upload_image_hotel(hotel_room)
    return unless params[:file].is_a? Array

    params[:file].each do |file|
      upload_multiple_file(hotel_room, file[:url], file[:type], file[:file_type])
    end
  end
end

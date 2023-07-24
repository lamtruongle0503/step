# frozen_string_literal: true

class Admin::Hotels::RoomsController < ApiV1Controller
  before_action :authentication!

  def index
    hotel_rooms = Admin::HotelOperations::RoomOperations::Index.new(actor, params).call
    render json:            hotel_rooms,
           each_serializer: Admin::Hotels::Rooms::IndexSerializer
  end

  def create
    Admin::HotelOperations::RoomOperations::Create.new(actor, params).call
    render json: {}
  end

  def update
    Admin::HotelOperations::RoomOperations::Update.new(actor, params).call
    render json: {}
  end

  def show
    hotel_room = Admin::HotelOperations::RoomOperations::Show.new(actor, params).call
    render json:       hotel_room,
           serializer: Admin::Hotels::Rooms::ShowSerializer
  end

  def destroy
    Admin::HotelOperations::RoomOperations::Destroy.new(actor, params).call
    render json: {}
  end
end

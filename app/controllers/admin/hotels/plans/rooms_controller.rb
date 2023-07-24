# frozen_string_literal: true

class Admin::Hotels::Plans::RoomsController < ApiV1Controller
  before_action :authentication!

  def index
    plan_rooms = Admin::HotelOperations::PlanOperations::RoomOperations::Index.new(actor, params).call
    render json:            plan_rooms,
           each_serializer: Admin::Hotels::Rooms::AttributesSerializer
  end
end

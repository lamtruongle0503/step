# frozen_string_literal: true

class Admin::HotelOperations::PlanOperations::RoomOperations::Index < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
    @hotel_plan = @hotel.hotel_plans.find(params[:plan_id])
  end

  def call
    authorize nil, Hotel::RoomPolicy

    @hotel_plan.hotel_rooms.setting_show.distinct
  end
end

# frozen_string_literal: true

class Admin::HotelOperations::PlanOperations::RoomSettingOperations::Index < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
    @hotel_plan = @hotel.hotel_plans.find(params[:plan_id])
    @hotel_plan_option = @hotel_plan.hotel_plan_option
  end

  def call
    authorize nil, Hotel::RoomPolicy

    return [] unless @hotel_plan_option.present?

    @hotel_plan_option.hotel_room_settings.where(hotel_room_id: params[:room_id]).order('date asc')
  end
end

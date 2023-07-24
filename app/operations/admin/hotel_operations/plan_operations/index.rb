# frozen_string_literal: true

class Admin::HotelOperations::PlanOperations::Index < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
  end

  def call
    authorize nil, Hotel::PlanPolicy

    @q = @hotel.hotel_plans.ransack(params[:q])
    @q.result.includes(:hotel_cancellation_policy, :hotel_room_settings, :hotel_rooms)
  end
end

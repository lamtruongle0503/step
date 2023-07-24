# frozen_string_literal: true

class Admin::HotelOperations::PlanOperations::Show < ApplicationOperation
  def call
    authorize nil, Hotel::PlanPolicy

    @hotel = Hotel.find(params[:hotel_id])
    @hotel_plan = @hotel.hotel_plans.find(params[:id])
  end
end

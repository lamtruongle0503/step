# frozen_string_literal: true

class Admin::HotelOperations::PlanOptionOperations::Show < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
    @hotel_plan = @hotel.hotel_plans.find(params[:plan_id])
  end

  def call
    authorize nil, Hotel::Plan::OptionPolicy

    @hotel_plan_option = @hotel_plan.hotel_plan_option
  end
end

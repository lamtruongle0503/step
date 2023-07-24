# frozen_string_literal: true

class Admin::HotelOperations::PlanOptionOperations::Index < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
    @hotel_plan = @hotel.hotel_plans.find(params[:plan_id])
  end

  def call
    authorize nil, Hotel::Plan::OptionPolicy

    return [] unless @hotel_plan.hotel_plan_option.present?

    @hotel_plan&.hotel_plan_option
  end
end

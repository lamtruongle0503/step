# frozen_string_literal: true

class Admin::HotelOperations::PlanOperations::MetaOperations::Index < ApplicationOperation
  def call
    Hotel.find(params[:hotel_id]).hotel_plans
  end
end

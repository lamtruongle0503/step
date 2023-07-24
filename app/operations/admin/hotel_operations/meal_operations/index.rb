# frozen_string_literal: true

class Admin::HotelOperations::MealOperations::Index < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
  end

  def call
    authorize nil, Hotel::MealPolicy

    @q = @hotel.hotel_meals.ransack(params[:q])
    @q.result(distinct: true)
  end
end

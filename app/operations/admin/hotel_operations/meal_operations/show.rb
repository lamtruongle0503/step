# frozen_string_literal: true

class Admin::HotelOperations::MealOperations::Show < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
  end

  def call
    authorize nil, Hotel::MealPolicy

    @hotel.hotel_meals.find(params[:id])
  end
end

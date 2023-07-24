# frozen_string_literal: true

class Admin::HotelOperations::MealOperations::MetaOperations::Index < ApplicationOperation
  def call
    Hotel.find(params[:hotel_id]).hotel_meals.use
  end
end

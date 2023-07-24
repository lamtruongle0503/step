# frozen_string_literal: true

class Admin::HotelOperations::MealOperations::Destroy < ApplicationOperation
  attr_reader :hotel_meal

  def initialize(actor, params)
    super
    @hotel_meal = Hotel::Meal.find(params[:id])
  end

  def call
    authorize nil, Hotel::MealPolicy

    ActiveRecord::Base.transaction do
      @hotel_meal.destroy!
    end
  end
end

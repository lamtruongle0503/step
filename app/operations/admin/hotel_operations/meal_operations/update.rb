# frozen_string_literal: true

require 'hotel/meal'
class Admin::HotelOperations::MealOperations::Update < ApplicationOperation
  attr_reader :hotel_meal

  def initialize(actor, params)
    super
    @hotel_meal = Hotel::Meal.find(params[:id])
  end

  def call
    authorize nil, Hotel::MealPolicy

    ActiveRecord::Base.transaction do
      HotelContracts::MealContracts::Update.new(hotel_meal_params).valid!
      hotel_meal.update!(hotel_meal_params)
      upload_image_hotel_meal(hotel_meal) if params[:file]
    end
  end

  private

  def hotel_meal_params
    params.permit(:address, :description, :management_name, :name, :type, :start_time,
                  :end_time, :is_used, :created_at, :updated_at)
  end

  def upload_image_hotel_meal(hotel_meal)
    return unless params[:file].is_a? Array

    params[:file].each do |file|
      upload_multiple_file(hotel_meal, file[:url], file[:type], file[:file_type])
    end
  end
end

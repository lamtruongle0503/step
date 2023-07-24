# frozen_string_literal: true

class Admin::Hotels::MealsController < ApiV1Controller
  before_action :authentication!

  def index
    hotel_meals = Admin::HotelOperations::MealOperations::Index.new(actor, params).call
    render json: hotel_meals, each_serializer: Admin::Hotels::Meals::IndexSerializer
  end

  def show
    hotel_meal = Admin::HotelOperations::MealOperations::Show.new(actor, params).call
    render json:       hotel_meal,
           serializer: Admin::Hotels::Meals::ShowSerializer
  end

  def create
    Admin::HotelOperations::MealOperations::Create.new(actor, params).call
    render json: {}
  end

  def update
    Admin::HotelOperations::MealOperations::Update.new(actor, params).call
    render json: {}
  end

  def destroy
    Admin::HotelOperations::MealOperations::Destroy.new(actor, params).call
    render json: {}
  end
end

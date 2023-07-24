# frozen_string_literal: true

class Admin::Hotels::Meals::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    hotel_meals = Admin::HotelOperations::MealOperations::MetaOperations::Index.new(actor, params).call
    render json: hotel_meals,
           each_serializer: Admin::Hotels::Meals::ShowSerializer,
           root: 'data', adapter: :json
  end
end

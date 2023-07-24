# frozen_string_literal: true

class Api::HotelOperations::Index < ApplicationOperation
  def call
    @q = Hotel.posting.ransack(params[:q])
    @q.result(distinct: true)
      .includes([hotel_plans: [hotel_meal: :assets, hotel_room_settings: :hotel_plan]], :assets)
      .newest.page(params[:page])
  end
end

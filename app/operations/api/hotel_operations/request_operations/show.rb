# frozen_string_literal: true

class Api::HotelOperations::RequestOperations::Show < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
  end

  def call
    @hotel.hotel_requests.find(params[:id])
  end
end

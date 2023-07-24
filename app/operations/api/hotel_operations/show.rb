# frozen_string_literal: true

class Api::HotelOperations::Show < ApplicationOperation
  def call
    @hotel = Hotel.find(params[:id])
  end
end

# frozen_string_literal: true

class Admin::HotelOperations::Destroy < ApplicationOperation
  def call
    hotel = Hotel.find(params[:id])
    ActiveRecord::Base.transaction do
      hotel.destroy!
    end
  end
end

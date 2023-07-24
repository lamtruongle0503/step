# frozen_string_literal: true

class Admin::HotelOperations::Show < ApplicationOperation
  def call
    Hotel.find(params[:id])
  end
end

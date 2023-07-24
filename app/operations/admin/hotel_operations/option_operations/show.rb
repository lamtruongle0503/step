# frozen_string_literal: true

require 'hotel/option'
class Admin::HotelOperations::OptionOperations::Show < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
  end

  def call
    authorize nil, Hotel::OptionPolicy

    @hotel.hotel_options.find(params[:id])
  end
end

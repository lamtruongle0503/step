# frozen_string_literal: true

require 'hotel/option'
class Admin::HotelOperations::OptionOperations::Index < ApplicationOperation
  def call
    authorize nil, Hotel::OptionPolicy

    hotel = Hotel.find(params[:hotel_id])
    @q = hotel.hotel_options.ransack(params[:q])
    @q.result(distinct: true)
  end
end

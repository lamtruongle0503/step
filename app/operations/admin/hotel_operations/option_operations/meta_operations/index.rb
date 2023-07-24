# frozen_string_literal: true

class Admin::HotelOperations::OptionOperations::MetaOperations::Index < ApplicationOperation
  def call
    Hotel.find(params[:hotel_id]).hotel_options.includes([:assets]).use
  end
end

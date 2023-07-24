# frozen_string_literal: true

class Admin::HotelOperations::ChildrenOperations::Show < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
  end

  def call
    authorize nil, Hotel::ChildrenPolicy

    @hotel.hotel_children_infos.find(params[:id])
  end
end

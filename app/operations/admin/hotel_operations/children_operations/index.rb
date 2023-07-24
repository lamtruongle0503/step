# frozen_string_literal: true

class Admin::HotelOperations::ChildrenOperations::Index < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
  end

  def call
    authorize nil, Hotel::ChildrenPolicy

    @q = @hotel.hotel_children_infos.ransack(params[:q])
    @q.result(distinct: true)
  end
end

# frozen_string_literal: true

class Admin::HotelOperations::ChildrenOperations::MetaOperations::Index < ApplicationOperation
  def call
    Hotel.find(params[:hotel_id]).hotel_children_infos
  end
end

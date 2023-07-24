# frozen_string_literal: true

class Admin::HotelOperations::ChildrenOperations::Destroy < ApplicationOperation
  def call
    authorize nil, Hotel::ChildrenPolicy

    Hotel::ChildrenInfo.find(params[:id])&.destroy
  end
end

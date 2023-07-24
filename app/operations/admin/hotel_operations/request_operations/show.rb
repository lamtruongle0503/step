# frozen_string_literal: true

class Admin::HotelOperations::RequestOperations::Show < ApplicationOperation
  def call
    authorize nil, Hotel::RequestPolicy

    Hotel::Request.find(params[:id])
  end
end

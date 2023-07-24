# frozen_string_literal: true

class Admin::HotelOperations::OrderOperations::Show < ApplicationOperation
  def call
    authorize nil, Hotel::OrderPolicy

    Hotel::Order.find(params[:id])
  end
end

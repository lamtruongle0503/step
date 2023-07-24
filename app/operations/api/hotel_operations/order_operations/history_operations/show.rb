# frozen_string_literal: true

class Api::HotelOperations::OrderOperations::HistoryOperations::Show < ApplicationOperation
  def call
    Hotel::Order.find(params[:id])
  end
end

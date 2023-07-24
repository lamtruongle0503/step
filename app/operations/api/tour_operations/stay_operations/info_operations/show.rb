# frozen_string_literal: true

class Api::TourOperations::StayOperations::InfoOperations::Show < ApplicationOperation
  def call
    Tour.find(params[:stay_id])
  end
end

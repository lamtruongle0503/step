# frozen_string_literal: true

class Api::TourOperations::StayOperations::Show < ApplicationOperation
  def call
    Tour.by_status_posted.find(params[:id])
  end
end

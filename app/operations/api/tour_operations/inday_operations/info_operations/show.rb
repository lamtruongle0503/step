# frozen_string_literal: true

class Api::TourOperations::IndayOperations::InfoOperations::Show < ApplicationOperation
  def call
    Tour.find(params[:inday_id])
  end
end

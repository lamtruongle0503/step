# frozen_string_literal: true

class Api::TourOperations::Show < ApplicationOperation
  def call
    Tour.find(params[:id])
  end
end

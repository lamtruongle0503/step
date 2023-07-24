# frozen_string_literal: true

class Admin::TourOperations::ManagementOperations::Show < ApplicationOperation
  def call
    authorize nil, Tour::ManagementPolicy

    Tour.find(params[:id])
  end
end

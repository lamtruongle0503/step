# frozen_string_literal: true

class Admin::TourOperations::ManagementOperations::ManagementFileOperations::Index < ApplicationOperation
  def call
    Tour::ManagementFile.where(tour_id: params[:management_id])
  end
end

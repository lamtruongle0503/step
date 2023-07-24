# frozen_string_literal: true

class Admin::TourOperations::ManagementOperations::Destroy < ApplicationOperation
  def call
    authorize nil, Tour::ManagementPolicy

    ActiveRecord::Base.transaction do
      Tour.find(params[:id])&.destroy!
    end
  end
end

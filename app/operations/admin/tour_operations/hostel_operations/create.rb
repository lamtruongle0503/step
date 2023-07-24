# frozen_string_literal: true

require 'tour/hostel'
class Admin::TourOperations::HostelOperations::Create < ApplicationOperation
  def call
    authorize nil, Tour::HostelPolicy

    ActiveRecord::Base.transaction do
      create_tour_hostel!
    end
  end

  private

  def create_tour_hostel!
    TourContracts::HostelContracts::Create.new(tour_hostel_params).valid!
    Tour::Hostel.create!(tour_hostel_params)
  end

  def tour_hostel_params
    params.permit(:name, :address1, :address2, :email, :note, :postal_code, :telephone, :description)
  end
end

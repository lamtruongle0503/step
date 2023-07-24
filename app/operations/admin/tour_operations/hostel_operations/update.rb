# frozen_string_literal: true

require 'tour/hostel'
class Admin::TourOperations::HostelOperations::Update < ApplicationOperation
  attr_reader :tour_hostel

  def initialize(actor, params)
    super
    @tour_hostel = Tour::Hostel.find(params[:id])
  end

  def call
    authorize nil, Tour::HostelPolicy

    ActiveRecord::Base.transaction do
      update_tour_hostel!
    end
  end

  private

  def update_tour_hostel!
    TourContracts::HostelContracts::Update.new(tour_hostel_params).valid!
    tour_hostel.update!(tour_hostel_params)
  end

  def tour_hostel_params
    params.permit(:name, :address1, :address2, :email, :note, :postal_code, :telephone, :description)
  end
end

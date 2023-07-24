# frozen_string_literal: true

require 'tour/hostel'
class Admin::TourOperations::HostelOperations::Show < ApplicationOperation
  def call
    authorize nil, Tour::HostelPolicy

    @tour_hostel = Tour::Hostel.find(params[:id])
  end
end

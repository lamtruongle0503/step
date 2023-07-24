# frozen_string_literal: true

require 'tour/hostel'
class Admin::TourOperations::HostelOperations::Destroy < ApplicationOperation
  def call
    authorize nil, Tour::HostelPolicy

    ActiveRecord::Base.transaction do
      Tour::Hostel.find(params[:id])&.destroy!
    end
  end
end

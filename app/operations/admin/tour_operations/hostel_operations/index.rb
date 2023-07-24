# frozen_string_literal: true

require 'tour/hostel'
class Admin::TourOperations::HostelOperations::Index < ApplicationOperation
  def call
    authorize nil, Tour::HostelPolicy

    @q = Tour::Hostel.ransack(params[:q])
    @q.result(distinct: true).newest.page(params[:page])
  end
end

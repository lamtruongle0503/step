# frozen_string_literal: true

require 'tour/hostel'
class Admin::TourOperations::HostelOperations::MetaOperations::Index < ApplicationOperation
  def call
    @q = Tour::Hostel.ransack(params[:q])
    @q.result(distinct: true)
  end
end

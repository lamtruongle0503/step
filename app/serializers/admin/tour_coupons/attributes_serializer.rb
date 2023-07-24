# frozen_string_literal: true

class Admin::TourCoupons::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :code, :start_time, :end_time, :created_at, :updated_at

  def start_date
    object&.start_time
  end

  def end_date
    object&.end_time
  end
end

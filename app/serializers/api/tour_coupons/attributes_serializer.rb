# frozen_string_literal: true

class Api::TourCoupons::AttributesSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :code,
             :start_time,
             :end_time,
             :start_date,
             :end_date,
             :coupons

  def coupons
    coupons = object.coupons
    coupons.map { |cp| Api::Coupons::AttributeSerializer.new(cp).as_json }
  end

  def start_date
    object&.start_time
  end

  def end_date
    object&.end_time
  end
end

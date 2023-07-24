# frozen_string_literal: true

class Admin::Tours::Points::AttributesSerializer < ApplicationSerializer
  attributes :id, :order_no, :departure_date, :address, :bus_no
  belongs_to :user, serializer: Admin::Users::IndexSerializer

  def address
    if object.tour.type_locate == Tour::INDAY
      object.tour_bus_info&.tour_start_location&.address
    else
      object.tour_bus_info&.tour_stay_departure&.address
    end
  end

  def bus_no
    object.tour_bus_info.bus_no
  end
end

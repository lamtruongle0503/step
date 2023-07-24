# frozen_string_literal: true

class Admin::Tours::IndexSerializer < Admin::Tours::AttributesSerializer
  attributes :staff_name, :tour_type, :status_tour_order_booked, :destination

  has_many :tour_start_locations, serializer: Admin::Tours::StartLocations::AttributesSerializer
  has_many :tour_stay_departures, serializer: Admin::Tours::StayDepartures::AttributesSerializer

  def staff_name
    object.company_staff&.name
  end

  def tour_type
    object.type_locate
  end

  def status_tour_order_booked
    object.tour_orders.where(status: Tour::Order::BOOKED).present?
  end
end

# frozen_string_literal: true

class Api::Tours::Orders::Histories::IndexSerializer < ApplicationSerializer
  attributes :id, :order_no, :created_at, :payment_status, :memo, :tour_type_locate, :total,
             :tour_order_assets, :tour_name, :status, :payment_method, :address, :bus_no, :start_date

  def created_at
    object.created_at.to_date
  end

  def tour_type_locate
    object.tour_order_log.tour['type_locate']
  end

  def tour_order_assets
    object.tour.assets
  end

  def tour_name
    object.tour.name
  end

  def total
    object.total.to_f.round
  end

  def address
    if object.tour.inday?
      object.tour_bus_info.tour_start_location.address
    else
      object.tour_bus_info.tour_stay_departure.address
    end
  end

  def bus_no
    object.tour_bus_info.bus_no
  end

  def start_date
    object.tour_bus_info.departure_date
  end
end

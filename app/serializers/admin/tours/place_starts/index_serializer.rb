# frozen_string_literal: true

class Admin::Tours::PlaceStarts::IndexSerializer < Admin::Tours::PlaceStarts::AttributesSerializer
  attributes :car_number, :amount_tour_booked

  def car_number
    object.tour_bus_infos.size
  end

  def amount_tour_booked
    object.tour_bus_infos.sum do |tour_bus_info|
      tour_bus_info.tour_orders
                   .by_status_not_in_cancel_and_special
                   .sum do |tour_order|
        tour_order.tour_order_accompanies.size
      end
    end
  end
end

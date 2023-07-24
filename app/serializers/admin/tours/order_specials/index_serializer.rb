# frozen_string_literal: true

class Admin::Tours::OrderSpecials::IndexSerializer < ApplicationSerializer
  attributes :id, :capacity_pattern, :code, :description, :name, :number_of_people,
             :amount_order
  attr_reader :tour, :tour_orders

  def initialize(actor, params)
    super
    @tour = object.tour if object
    @tour_orders = tour.tour_orders if tour
  end

  def amount_order
    return unless tour_orders.present?

    case object.code
    when Tour::OrderSpecial::FULL_PLACE
      tour_orders.by_status_full_place.inject(0) do |sum, tour_order|
        sum + tour_order.tour_order_accompanies.size
      end
    when Tour::OrderSpecial::CXL
      tour_orders.by_status_cancel.inject(0) do |sum, tour_order|
        sum + tour_order.tour_order_accompanies.size
      end
    when Tour::OrderSpecial::CXL_WAITING
      tour_orders.by_status_cxl_waiting.inject(0) do |sum, tour_order|
        sum + tour_order.tour_order_accompanies.size
      end
    when Tour::OrderSpecial::TEMPORARI
      tour.tour_order_specials.where(code: Tour::OrderSpecial::TEMPORARI).inject(0) do |sum, tour_order|
        sum + tour_order.tour_temporaries.size
      end
    else
      0
    end
  end
end

# frozen_string_literal: true

class Admin::Tours::Managements::BusInfos::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :code, :company_name, :category_name, :branch_name, :status, :company_staff_name,
             :car_number, :amount_tour_booked, :start_date, :end_date, :first_row_seat_price,
             :two_rows_seat_price, :regular_seat_price

  def company_name
    object.tour_company&.name
  end

  def category_name
    object.tour_category&.name
  end

  def branch_name
    object.company_staff&.company_branch&.name
  end

  def company_staff_name
    object.company_staff&.name
  end

  def car_number
    object.tour_bus_infos&.size
  end

  def amount_tour_booked
    object.tour_orders.by_status_not_in_cancel_and_special&.size
  end
end

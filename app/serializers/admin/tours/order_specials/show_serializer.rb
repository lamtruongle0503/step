# frozen_string_literal: true

class Admin::Tours::OrderSpecials::ShowSerializer < Admin::Tours::OrderSpecials::AttributesSerializer
  attributes :tour_name, :tour_no, :company_name, :tour_category_name, :tour_status, :tour_branch_name,
             :number_bus, :company_staff_name, :number_people_booking, :tour_start_date, :tour_end_date

  def tour_name
    object.tour&.name
  end

  def tour_no
    object.tour&.code
  end

  def company_name
    object.tour&.tour_company&.name
  end

  def tour_category_name
    object.tour&.tour_category&.name
  end

  def tour_status
    object.tour&.status
  end

  def tour_start_date
    object.tour&.start_date
  end

  def tour_end_date
    object.tour&.end_date
  end

  def tour_branch_name
    object.tour&.company_staff&.company_branch&.name
  end

  def number_bus
    object.tour&.tour_bus_infos&.size
  end

  def company_staff_name
    object.tour&.company_staff&.name
  end

  def number_people_booking
    # number = 0
    # return number unless object.tour&.tour_bus_infos.present?

    # object.tour&.tour_bus_infos.includes(:tour_bus_pattern).map do |obj|
    #   capacity = obj.tour_bus_pattern.capacity
    #   number += capacity - obj.available_seats
    # end
    # number
    object.tour.tour_temporaries.size
  end
end

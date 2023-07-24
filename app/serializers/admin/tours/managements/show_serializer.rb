# frozen_string_literal: true

class Admin::Tours::Managements::ShowSerializer < Admin::Tours::Managements::AttributesSerializer
  attributes :company_name, :category_name, :branch_name, :status, :company_staff_name, :car_number,
             :amount_tour_booked, :start_date, :end_date

  has_many :tour_stay_departures, serializer: Admin::Tours::StayDepartures::BusInfos::AttributesSerializer
  has_many :tour_start_locations, serializer: Admin::Tours::StartLocations::BusInfos::AttributesSerializer

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
    object.tour_temporaries.size
  end
end

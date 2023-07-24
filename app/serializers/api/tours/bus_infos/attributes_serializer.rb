# frozen_string_literal: true

class Api::Tours::BusInfos::AttributesSerializer < ApplicationSerializer
  attributes :id, :code, :available_seats, :bus_no, :day_of_week, :departure_date, :is_weekend,
             :address, :reserved_seats, :seats_map, :first_row_seat_price, :two_rows_seat_price,
             :regular_seat_price, :min_price_calendar, :lock_calendar, :tour_place_start_id,
             :tour_start_location_id, :concentrate_time, :departure_time

  def code
    if object.tour.type_locate == Tour::STAY
      object&.tour_stay_departure&.code
    else
      object&.tour_start_location&.code
    end
  end

  def first_row_seat_price
    object.tour.first_row_seat_price
  end

  def two_rows_seat_price
    object.tour.two_rows_seat_price
  end

  def regular_seat_price
    object.tour.regular_seat_price
  end

  def min_price_calendar
    if object.tour.type_locate == Tour::STAY
      (object.tour.tour_information.min_price - object.tour.discount).round
    elsif object.is_weekend == Tour::BusInfo::WEEKDAY
      object.tour.tour_information.adult_dayoff_amount.round
    else
      object.tour.tour_information.adult_weekday_amount.round
    end
  end

  def address
    return object.tour_stay_departure.address if object.tour_stay_departure_id.present?

    object&.tour_start_location&.address
  end

  def lock_calendar
    (object.departure_date.to_datetime - 1.day).change(
      { hour: 17, min: 0o1, sec: 0 },
    ).strftime('%Y/%m/%d %H:%M:%S') <= Time.zone.now.strftime('%Y/%m/%d %H:%M:%S')
  end

  def tour_start_location_id
    object.tour_start_location_id || object.tour_stay_departure_id
  end
end

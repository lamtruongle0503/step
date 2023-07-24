# frozen_string_literal: true

class Admin::TourOperations::Show < ApplicationOperation
  def call
    authorize nil, TourPolicy

    Tour.includes(
      tour_start_locations: :prefecture, tour_special_foods: %i[assets_modules assets],
      tour_options: %i[assets_modules assets], hostel_departures: :tour_hostel,
      tour_stay_departures: :prefecture
    ).find(params[:id])
  end
end

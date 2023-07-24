# frozen_string_literal: true

class Admin::TourOperations::ManagementOperations::Index < ApplicationOperation
  def call
    authorize nil, Tour::ManagementPolicy

    @q = Tour.includes(
      :tour_company,
      :tour_category,
      company_staff:     :company_branch,
      tour_place_starts: [
        :prefecture,
        { tour_start_locations: :prefecture,
          tour_stay_departures: :prefecture,
          tour_bus_infos:       :tour_orders },
      ],
    ).ransack(params[:q])
    @q.result(distinct: true).newest.page(params[:page])
  end
end

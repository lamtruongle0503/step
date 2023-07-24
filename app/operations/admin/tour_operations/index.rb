# frozen_string_literal: true

class Admin::TourOperations::Index < ApplicationOperation
  def call
    authorize nil, TourPolicy

    @q = Tour.includes(
      :tour_category, { company_staff: :company_branch }, :tour_company,
      tour_start_locations: [:prefecture], tour_stay_departures: [:prefecture]
    ).ransack(params[:q])
    @q.result(distinct: true).newest.page(params[:page])
  end
end

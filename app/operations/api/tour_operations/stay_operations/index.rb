# frozen_string_literal: true

class Api::TourOperations::StayOperations::Index < ApplicationOperation
  attr_reader :tour_stay

  def initialize(actor, params)
    super

    @tour_stay = actor.present? ? search_tour_near_user(actor, Tour::STAY) : []
  end

  def call
    Kaminari.paginate_array(tour_stay +
      (Tour.by_end_date(Date.current, Tour.type_locates[Tour::STAY]).by_status_posted
        .newest.includes(
          :assets, :tour_information, :tour_category, :tour_stay_departures, :tour_options,
          :hostels_tours, :hostels
        ).ransack(params[:q]).result(distinct: true) - tour_stay)).page(params[:page]).per(params[:per_page])
  end
end

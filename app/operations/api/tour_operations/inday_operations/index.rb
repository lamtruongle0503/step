# frozen_string_literal: true

class Api::TourOperations::IndayOperations::Index < ApplicationOperation
  attr_reader :tour_inday

  def initialize(actor, params)
    super
    @tour_inday = actor.present? ? search_tour_near_user(actor, Tour::INDAY) : []
  end

  def call
    Kaminari.paginate_array(
      tour_inday +
      (Tour.by_end_date(Date.current, Tour.type_locates[Tour::INDAY]).by_status_posted
          .includes(:assets, :tour_information, :tour_category, :tour_start_locations).newest
          .ransack(params[:q]).result(distinct: true) - tour_inday),
    ).page(params[:page]).per(params[:per_page])
  end
end

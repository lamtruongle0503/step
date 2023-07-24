# frozen_string_literal: true

require 'tour/order'
class Admin::TourOperations::PlaceStartOperations::Create < ApplicationOperation
  attr_reader :tour

  def initialize(actor, params)
    super
    @tour = Tour.find(params[:tour_id])
  end

  def call
    authorize nil, TourPolicy

    ActiveRecord::Base.transaction do
      place_start = create_tour_place_start!(tour)
      if tour.type_locate == Tour::INDAY
        create_tour_start_location!(tour, place_start)
      else
        create_tour_stay_departure!(tour, place_start)
      end
    end
  end

  private

  def create_tour_place_start!(tour)
    TourContracts::PlaceStartContracts::Create.new(tour_place_start_params.merge(tour_id: tour.id)).valid!
    tour.tour_place_starts.create!(tour_place_start_params)
  end

  def create_tour_start_location!(tour, place_start)
    tour_start_locations_params[:tour_start_locations].each do |tour_start_location_params|
      create_start_locations!(tour, tour_start_location_params.merge!(tour_place_start_id: place_start.id))
    end
  end

  def create_tour_stay_departure!(tour, place_start)
    tour_stay_departure_params[:tour_stay_departures].each do |tour_stay_departure|
      create_stay_departure!(tour, tour_stay_departure.merge!(tour_place_start_id: place_start.id))
    end
  end

  def tour_place_start_params
    params.permit(:code, :prefecture_id)
  end

  def tour_start_locations_params
    unless params[:tour_start_locations]
      raise BadRequestError,
            tour_start_locations: I18n.t('models.can_not_blank')
    end

    params.permit(tour_start_locations: %i[name depature_time concentrate_time code tour_place_start_id
                                           setting_date prefecture_id address is_setting])
  end

  def tour_stay_departure_params
    unless params[:tour_stay_departures]
      raise BadRequestError,
            tour_stay_departures: I18n.t('models.can_not_blank')
    end

    params.permit(
      tour_stay_departures: %i[
        id address name concentrate_time depature_time one_person_fee two_person_fee
        three_person_fee four_person_fee setting_date prefecture_id is_setting code
        tour_place_start_id
      ],
    )
  end
end

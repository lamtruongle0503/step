# frozen_string_literal: true

require 'tour/order'
class Admin::TourOperations::PlaceStartOperations::Update < ApplicationOperation
  attr_reader :tour, :tour_place_start, :tour_place_starts_old, :tour_bus_info_ids

  def initialize(actor, params)
    super
    @tour = Tour.find(params[:tour_id])
    @tour_place_start = tour.tour_place_starts.find(params[:id])
    @tour_place_starts_old = tour_place_start.tour_start_locations |
                             tour_place_start.tour_stay_departures
    @tour_bus_info_ids = tour.tour_orders.pluck(:tour_bus_info_id).uniq
  end

  def call
    authorize nil, TourPolicy

    ActiveRecord::Base.transaction do
      update_tour_place_start!(tour_place_start)
      if tour.type_locate == Tour::INDAY
        update_tour_start_location!(tour, tour_place_starts_old)
      else
        update_tour_stay_departure!(tour, tour_place_starts_old)
      end
    end
  end

  private

  def update_tour_place_start!(tour_place_start)
    TourContracts::PlaceStartContracts::Update.new(tour_place_start_params.merge(tour_id: tour.id)).valid!
    tour_place_start.update!(tour_place_start_params)
  end

  def update_tour_start_location!(tour, tour_place_starts_old)
    new_tour_start_locations_ids = tour_start_locations_params[:tour_start_locations].pluck(:id).compact
    old_tour_start_locations_ids = tour_place_starts_old.pluck(:id) - new_tour_start_locations_ids
    if old_tour_start_locations_ids.present?
      check_bus_infos_selected(old_tour_start_locations_ids)
      destroy_start_locations!(old_tour_start_locations_ids)
    end
    tour_start_locations_params[:tour_start_locations].each do |tour_start_location_params|
      tour_start_location_params.merge!(
        tour_place_start_id: tour_place_start.id,
        prefecture_id:       tour_place_start.prefecture_id,
      )
      if tour_start_location_params[:id].blank?
        create_start_locations!(tour, tour_start_location_params)
      else
        update_start_locations!(tour_start_location_params)
      end
    end
  end

  def update_tour_stay_departure!(tour, tour_place_starts_old)
    new_stay_departures_ids = tour_stay_departure_params[:tour_stay_departures].pluck(:id).compact
    old_stay_departures_ids = tour_place_starts_old.pluck(:id) - new_stay_departures_ids
    if old_stay_departures_ids.present?
      check_bus_infos_selected(old_stay_departures_ids)
      destroy_stay_departure!(old_stay_departures_ids)
    end
    tour_stay_departure_params[:tour_stay_departures].each do |tour_stay_departure|
      tour_stay_departure.merge!(
        tour_place_start_id: tour_place_start.id,
        prefecture_id:       tour_place_start.prefecture_id,
      )
      if tour_stay_departure[:id].blank?
        create_stay_departure!(tour, tour_stay_departure)
      else
        update_stay_departure!(tour_stay_departure)
      end
    end
  end

  def update_start_locations!(tour_start_location_params)
    TourContracts::TourStartLocationContracts::Update.new(
      tour_start_location_params.merge(tour_id: tour.id),
    ).valid!
    tour_start_location = tour.tour_start_locations.find(tour_start_location_params[:id])
    tour_start_location_params[:depature_time] = nil if tour_start_location_params[:is_setting].present?
    tour_start_location_params[:concentrate_time] = nil if tour_start_location_params[:is_setting].present?
    tour_start_location.update!(tour_start_location_params)
    tour_start_location.tour_bus_infos.update_all(departure_date: tour_start_location.setting_date)
  end

  def update_stay_departure!(tour_stay_departure)
    TourContracts::StayDepartureContracts::Update.new(
      tour_stay_departure.merge(
        tour_id:   tour.id,
        min_price: tour.tour_information.min_price,
        max_price: tour.tour_information.max_price,
      ),
    ).valid!
    stay_departure = tour.tour_stay_departures.find(tour_stay_departure[:id])
    tour_stay_departure[:depature_time] = nil if tour_stay_departure[:is_setting].present?
    tour_stay_departure[:concentrate_time] = nil if tour_stay_departure[:is_setting].present?
    stay_departure.update!(tour_stay_departure)
    stay_departure.tour_bus_infos.update_all(departure_date: stay_departure.setting_date)
  end

  def destroy_stay_departure!(old_stay_departures_ids)
    old_stay_departures_ids.each do |old_id|
      tour.tour_stay_departures.find(old_id).tour_bus_infos.destroy_all
    end
    tour.tour_stay_departures.where(id: old_stay_departures_ids).destroy_all
  end

  def destroy_start_locations!(old_tour_start_locations_ids)
    old_tour_start_locations_ids.each do |old_id|
      tour.tour_start_locations.find(old_id).tour_bus_infos.destroy_all
    end
    tour.tour_start_locations.where(id: old_tour_start_locations_ids).destroy_all
  end

  def check_bus_infos_selected(old_ids)
    old_ids.each do |old_id|
      bus_old_ids = get_bus_old_ids(old_id)
      bus_old_ids.each do |bus_old_id|
        if tour_bus_info_ids.include?(bus_old_id)
          raise BadRequestError,
                tour_bus_info: I18n.t('order_tours.bus_infos.booked')
        end
      end
    end
  end

  def get_bus_old_ids(old_id)
    if tour.type_locate == Tour::INDAY
      tour.tour_start_locations.find(old_id).tour_bus_infos.pluck(:id).uniq
    else
      tour.tour_stay_departures.find(old_id).tour_bus_infos.pluck(:id).uniq
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

    params.permit(tour_start_locations: %i[id name depature_time concentrate_time code tour_place_start_id
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

# frozen_string_literal: true

require 'tour/information'
require 'tour/start_location'
class Admin::TourOperations::Update < ApplicationOperation # rubocop:disable Metrics/ClassLength
  attr_reader :tour, :tour_bus_info_ids

  def initialize(actor, params)
    super
    @tour = Tour.includes(:tour_start_locations, :coupons).find(params[:id])
    @tour_bus_info_ids = tour.tour_orders.pluck(:tour_bus_info_id).uniq
  end

  def call
    authorize nil, TourPolicy

    ActiveRecord::Base.transaction do
      update_tour!
      update_tour_information!(tour)
      update_tour_special_foods!(tour)
      update_coupons!(tour)
      update_tour_hostel!(tour)
      if params[:type_locate] == Tour::STAY
        update_tour_options!(tour)
        update_tour_hostel_departures!(tour)
        update_tour_payment!(tour)
      end
      update_coupon_tour!(tour)
      upload_assets_tour!(tour)
    end
  end

  private

  def update_tour!
    ActiveRecord::Base.transaction do
      TourContracts::Update.new(tour_params.merge(record: tour)).valid!
      tour.update!(tour_params)
    end
  end

  def update_tour_information!(tour)
    TourContracts::TourInformationContracts::Update.new(
      tour_information_params.merge(tour_id: tour.id),
    ).valid!
    tour.tour_information.update!(tour_information_params)
  end

  def update_tour_payment!(tour)
    payment_ids = tour.payments.pluck(:id)

    return if params[:payment_ids] == payment_ids

    add_payment_ids    = params[:payment_ids] - payment_ids
    remove_payment_ids = payment_ids - params[:payment_ids]

    tour.tour_payments.where(payment_id: remove_payment_ids).destroy_all
    add_payment_ids.each do |payment_id|
      tour.tour_payments.create!(payment_id: payment_id)
    end
  end

  def update_tour_special_foods!(tour)
    new_special_foods_ids = tour_special_foods_params[:tour_special_foods].pluck(:id).compact
    old_special_foods_ids = tour.tour_special_foods.pluck(:id) - new_special_foods_ids
    destroy_special_foods!(old_special_foods_ids) if old_special_foods_ids.present?
    tour_special_foods_params[:tour_special_foods].each do |tour_special_food|
      if tour_special_food[:id].blank?
        create_special_foods!(tour, tour_special_food)
      else
        update_special_foods!(tour_special_food)
      end
    end
  end

  def update_special_foods!(tour_special_food)
    TourContracts::SpecialFoodContracts::Update.new(
      tour_special_food.merge(tour_id: tour.id),
    ).valid!
    special_food = tour.tour_special_foods.find(tour_special_food[:id])
    special_food.update!(tour_special_food.except(:file))
    upload_assets_food(tour_special_food, special_food, tour_special_food[:file])
  end

  def destroy_special_foods!(old_special_foods_ids)
    tour.tour_special_foods.where(id: old_special_foods_ids).destroy_all
  end

  def update_coupons!(tour)
    new_coupons_ids = coupon_params[:coupons].pluck(:id).compact
    old_coupons_ids = tour.coupons.pluck(:id) - new_coupons_ids
    destroy_coupon!(old_coupons_ids) if old_coupons_ids.present?
    coupon_params[:coupons].each do |coupon|
      if coupon[:id].blank?
        create_coupon!(tour, coupon)
      else
        update_coupon!(coupon)
      end
    end
  end

  def update_coupon!(coupon)
    TourContracts::CouponContracts::Update.new(
      coupon.merge(tour_id: tour.id),
    ).valid!
    coupon_prefecture = tour.coupons.find_by(id: coupon[:id])
    update_coupons_prefecture!(tour, coupon_prefecture)
    coupon_prefecture.update!(coupon)
  end

  def destroy_coupon!(old_coupons_ids)
    tour.coupons.where(id: old_coupons_ids).destroy_all
  end

  def update_tour_hostel!(tour)
    return unless params[:hostel_ids]

    old_hostel_ids = tour.hostels_tours.pluck(:tour_hostel_id) - params[:hostel_ids]
    new_hostel_ids = params[:hostel_ids] - tour.hostels_tours.pluck(:tour_hostel_id)
    destroy_hotel_tour!(old_hostel_ids) if old_hostel_ids.present?
    create_hotel_tour!(new_hostel_ids) if new_hostel_ids.present?
  end

  def destroy_hotel_tour!(old_hostel_ids)
    tour.hostels_tours.where(id: old_hostel_ids).destroy_all
  end

  def create_hotel_tour!(new_hostel_ids)
    new_hostel_ids.each do |hostel_id|
      tour.hostels_tours.create!(tour_hostel_id: hostel_id)
    end
  end

  def update_tour_hostel_departures!(tour)
    new_hostel_departures_ids = tour_hostel_departures_params[:tour_hostel_departures].pluck(:id).compact
    old_hostel_departures_ids = tour.hostel_departures.pluck(:id) - new_hostel_departures_ids
    destroy_hostel_departure!(old_hostel_departures_ids) if old_hostel_departures_ids.present?
    tour_hostel_departures_params[:tour_hostel_departures].each do |tour_hostel_departure|
      convert_tour_stay_departure_params(tour, tour_hostel_departure)
      if tour_hostel_departure[:id].blank?
        create_hostel_departure!(tour, tour_hostel_departure)
      else
        update_hostel_departure!(tour_hostel_departure)
      end
    end
  end

  def convert_tour_stay_departure_params(tour, tour_hostel_departure)
    params[:tour_options].each do |tour_option|
      tour_option_created = tour.tour_options.find_by(code: tour_option[:code])
      tour_hostel_departure[:option_ids].map! do |option_code|
        option_code == tour_option[:code] ? tour_option_created.id : option_code
      end
    end
  end

  def update_hostel_departure!(tour_hostel_departure)
    TourContracts::HostelDepartureContracts::Update.new(
      tour_hostel_departure.merge(tour_id: tour.id),
    ).valid!
    tour.hostel_departures.find(tour_hostel_departure[:id]).update!(tour_hostel_departure)
  end

  def destroy_hostel_departure!(old_hostel_departures_ids)
    tour.hostel_departures.where(id: old_hostel_departures_ids).destroy_all
  end

  def update_tour_options!(tour)
    new_options_ids = tour_option_params[:tour_options].pluck(:id).compact
    old_options_ids = tour.tour_options.pluck(:id) - new_options_ids
    destroy_tour_option!(old_options_ids) if old_options_ids.present?
    tour_option_params[:tour_options].each do |tour_option|
      if tour_option[:id].blank?
        next if tour_option.blank?

        create_tour_option!(tour, tour_option)
      else
        update_tour_option!(tour_option)
      end
    end
  end

  def update_tour_option!(tour_option)
    option = tour.tour_options.find(tour_option[:id])
    TourContracts::TourOptionContracts::Update.new(
      tour_option.merge(tour_id: tour.id, record: option),
    ).valid!
    option.update!(tour_option.except(:file))
    upload_assets_option(tour_option, option, tour_option[:file])
  end

  def destroy_tour_option!(old_options_ids)
    tour.tour_options.where(id: old_options_ids).destroy_all
  end

  def update_coupon_tour!(tour)
    tour.coupon_tours.each do |coupon_tour|
      coupon_tour.update!(
        start_time: tour.start_time,
        end_time:   tour.end_time,
        updated_at: Time.zone.now,
      )
      update_coupon_tour_prefecture!(coupon_tour.reload)
    end
  end

  def tour_params
    params.permit(
      :code, :name, :type_locate, :company_staff_id, :stayed_nights, :destination,
      :discount, :point_bonus_rate, :point_receive_rate, :exp_point_bonus,
      :exp_point_receive, :start_date, :end_date, :first_row_seat_price,
      :regular_seat_price, :two_rows_seat_price, :hostel_ids, :is_show_guide,
      :meal_description, :tax, :title, :tour_guide, :tour_category_id,
      :tour_company_id, :tour_cancellation_policy_id, :options, :sight_seeing,
      :scheduler, :note, :stop_locations, :hotel_description, :status, :stopover,
      :start_time, :end_time, :info_travel_fee, :transport_used, :plan_implement,
      :min_number_participant, :other_fee
    )
  end

  def tour_information_params
    raise BadRequestError, tour_information: I18n.t('models.can_not_blank') unless params[:tour_information]

    params[:tour_information].permit(%i[
                                       adult_dayoff_discount adult_dayoff_price adult_weekday_discount
                                       adult_weekday_price baby_dayoff_discount baby_dayoff_price
                                       baby_weekday_discount baby_weekday_price children_dayoff_discount
                                       children_dayoff_price children_weekday_discount children_weekday_price
                                       max_price min_price adult_weekday_amount adult_dayoff_amount
                                       children_weekday_amount children_dayoff_amount baby_weekday_amount
                                       baby_dayoff_amount
                                     ])
  end

  def tour_start_locations_params
    unless params[:tour_start_locations]
      raise BadRequestError,
            tour_start_locations: I18n.t('models.can_not_blank')
    end

    params.permit(tour_start_locations: %i[id name depature_time concentrate_time
                                           setting_date prefecture_id address is_setting])
  end

  def tour_special_foods_params
    unless params[:tour_special_foods]
      raise BadRequestError,
            tour_special_foods: I18n.t('models.can_not_blank')
    end
    params.permit(tour_special_foods: [:id, :name, :code, :price, :is_free, { file: %i[file_type url type] }])
  end

  def coupon_params
    unless params[:coupons]
      raise BadRequestError,
            coupons: I18n.t('models.can_not_blank')
    end

    params.permit(coupons: %i[id price start_time end_time])
  end

  def tour_stay_departure_params
    unless params[:tour_stay_departures]
      raise BadRequestError,
            tour_stay_departures: I18n.t('models.can_not_blank')
    end

    params.permit(
      tour_stay_departures: %i[
        id address concentrate_time depature_time one_person_fee two_person_fee
        name three_person_fee four_person_fee setting_date prefecture_id is_setting
      ],
    )
  end

  def tour_hostel_departures_params
    unless params[:tour_hostel_departures]
      raise BadRequestError,
            tour_hostel_departures: I18n.t('models.can_not_blank')
    end

    params.permit(tour_hostel_departures: [:id, :note, :tour_hostel_id, { option_ids: [] }])
  end

  def tour_option_params
    unless params[:tour_options]
      raise BadRequestError,
            tour_options: I18n.t('models.can_not_blank')
    end

    params.permit(tour_options: [:id, :code, :name, :price, :is_free, :deleted_at,
                                 { file: %i[file_type url type] }])
  end
end

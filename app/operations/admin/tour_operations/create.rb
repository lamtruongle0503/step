# frozen_string_literal: true

require 'tour/information'
class Admin::TourOperations::Create < ApplicationOperation
  def call
    authorize nil, TourPolicy

    ActiveRecord::Base.transaction do
      tour = create_tour!
      create_tour_information!(tour)
      create_tour_special_foods!(tour)
      create_coupons!(tour)
      create_tour_hostel!(tour)
      create_tour_order_special!(tour)
      if params[:type_locate] == Tour::STAY
        create_tour_options!(tour)
        create_tour_hostel_departures!(tour)
        create_tour_payments(tour)
      end
      upload_assets_tour!(tour)
      tour
    end
  end

  private

  def create_tour!
    TourContracts::Create.new(tour_params).valid!
    Tour.create!(tour_params)
  end

  def create_tour_payments(tour)
    params[:payment_ids].each do |payment_id|
      tour.tour_payments.create(payment_id: payment_id)
    end
  end

  def create_tour_information!(tour)
    TourContracts::TourInformationContracts::Create.new(
      tour_information_params.merge(tour_id: tour.id),
    )
    tour.create_tour_information!(tour_information_params)
  end

  def upload_assets_tour!(tour)
    return unless params[:file].is_a? Array

    params[:file].each do |file|
      upload_multiple_file(tour, file[:url], file[:type], file[:file_type])
    end
  end

  def create_tour_special_foods!(tour)
    tour_special_foods_params[:tour_special_foods].each do |tour_special_food|
      create_special_foods!(tour, tour_special_food)
    end
  end

  def create_coupons!(tour)
    coupon_params[:coupons].each do |coupon|
      create_coupon!(tour, coupon)
    end
  end

  def create_tour_hostel!(tour)
    return unless params[:hostel_ids]

    params[:hostel_ids].each do |hostel_id|
      tour.hostels_tours.create!(tour_hostel_id: hostel_id)
    end
  end

  def create_tour_hostel_departures!(tour)
    tour_hostel_departures_params[:tour_hostel_departures].each do |tour_hostel_departure|
      convert_tour_stay_departure_params(tour, tour_hostel_departure)
      create_hostel_departure!(tour, tour_hostel_departure)
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

  def create_tour_options!(tour)
    tour_option_params[:tour_options].each do |tour_option|
      next if tour_option.blank?

      create_tour_option!(tour, tour_option)
    end
  end

  def create_tour_order_special!(tour)
    arr = []
    Tour::OrderSpecial::SPECIAL.each do |special|
      case special
      when Tour::OrderSpecial::FULL_PLACE
        code        = special
        description = I18n.t('tour.special_description.full_place')
        name        = I18n.t('tour.special_name.full_place')
      when Tour::OrderSpecial::TEMPORARI
        code        = special
        description = I18n.t('tour.special_description.temporari')
        name        = I18n.t('tour.special_name.temporari')
      when Tour::OrderSpecial::CXL
        code        = special
        description = I18n.t('tour.special_description.cxl')
        name        = I18n.t('tour.special_name.cxl')
      when Tour::OrderSpecial::CXL_WAITING
        code        = special
        description = I18n.t('tour.special_description.cxl_waiting')
        name        = I18n.t('tour.special_name.cxl_waiting')
      end
      arr << { name: name, code: code, description: description, tour_id: tour.id }
    end
    Tour::OrderSpecial.import! arr
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
                                       adult_dayoff_discount
                                       adult_dayoff_price
                                       adult_weekday_discount
                                       adult_weekday_price
                                       baby_dayoff_discount
                                       baby_dayoff_price
                                       baby_weekday_discount
                                       baby_weekday_price
                                       children_dayoff_discount
                                       children_dayoff_price
                                       children_weekday_discount
                                       children_weekday_price
                                       max_price
                                       min_price
                                       adult_weekday_amount
                                       adult_dayoff_amount
                                       children_weekday_amount
                                       children_dayoff_amount
                                       baby_weekday_amount
                                       baby_dayoff_amount
                                     ])
  end

  def tour_start_locations_params
    unless params[:tour_start_locations]
      raise BadRequestError,
            tour_start_locations: I18n.t('models.can_not_blank')
    end

    params.permit(tour_start_locations: %i[name depature_time concentrate_time
                                           setting_date prefecture_id address is_setting])
  end

  def tour_special_foods_params
    unless params[:tour_special_foods]
      raise BadRequestError,
            tour_special_foods: I18n.t('models.can_not_blank')
    end
    params.permit(tour_special_foods: [:code, :name, :price, :is_free, { file: %i[file_type url type] }])
  end

  def coupon_params
    unless params[:coupons]
      raise BadRequestError,
            coupons: I18n.t('models.can_not_blank')
    end

    params.permit(coupons: %i[price start_time end_time])
  end

  def tour_stay_departure_params
    unless params[:tour_stay_departures]
      raise BadRequestError,
            tour_stay_departures: I18n.t('models.can_not_blank')
    end

    params.permit(
      tour_stay_departures: %i[
        id address name concentrate_time depature_time one_person_fee two_person_fee
        three_person_fee four_person_fee setting_date prefecture_id is_setting
      ],
    )
  end

  def tour_hostel_departures_params
    unless params[:tour_hostel_departures]
      raise BadRequestError,
            tour_hostel_departures: I18n.t('models.can_not_blank')
    end

    params.permit(tour_hostel_departures: [:note, :tour_hostel_id, { option_ids: [] }])
  end

  def tour_option_params
    unless params[:tour_options]
      raise BadRequestError,
            tour_options: I18n.t('models.can_not_blank')
    end

    params.permit(tour_options: [:code, :name, :price, :is_free, { file: %i[file_type url type] }])
  end
end

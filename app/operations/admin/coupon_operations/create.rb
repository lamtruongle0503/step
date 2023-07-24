# frozen_string_literal: true

class Admin::CouponOperations::Create < ApplicationOperation
  attr_reader :tour_coupon

  def initialize(actor, params)
    super
    @tour_coupon = TourCoupon.find_by(code: params[:code])
  end

  def call
    authorize Coupon
    CouponContracts::Create.new(coupon_params).valid!
    ActiveRecord::Base.transaction do
      create_tour_coupon!
      coupon_tour = create_coupon_tour!
      create_coupon_with_file!(coupon_tour)
      create_tours_prefecture!(tour_coupon)
      create_coupon_tour_prefecture!(coupon_tour)
    end
  end

  private

  def create_coupon!(coupon_tour)
    Coupon.create!(
      start_time:   params[:start_time],
      end_time:     params[:end_time],
      publish_date: params[:publish_date],
      is_notice:    params[:is_notice],
      coupon_tour:  coupon_tour,
    )
  end

  def create_coupon_tour!
    CouponTour.create!(coupon_tour_params.merge!(tour_coupon: tour_coupon))
  end

  def create_tour_coupon!
    return if tour_coupon

    TourCouponContracts::Create.new(tour_coupon_params.merge(prefecture_ids: params[:prefecture_ids])).valid!
    @tour_coupon = TourCoupon.create!(tour_coupon_params)
  end

  def create_tours_prefecture!(tour)
    params[:prefecture_ids].each do |prefecture_id|
      tour.tours_prefectures.create(prefecture_id: prefecture_id)
    end
  end

  def create_coupons_prefecture!(coupon)
    params[:prefecture_ids].each do |prefecture_id|
      coupon.coupons_prefectures.create(prefecture_id: prefecture_id)
    end
  end

  def create_coupon_tour_prefecture!(coupon_tour)
    params[:prefecture_ids].each do |prefecture_id|
      coupon_tour.coupon_tour_prefectures.create(prefecture_id: prefecture_id)
    end
  end

  def create_tours_coupons!(tour, coupon)
    tour.coupons << coupon
  end

  def create_coupon_with_file!(coupon_tour)
    return unless params[:file]

    if params[:file].is_a? Array
      params[:file].each do |file|
        coupon = create_coupon!(coupon_tour)
        create_coupons_prefecture!(coupon)
        create_tours_coupons!(tour_coupon, coupon)
        upload_multiple_file(coupon, file[:url], file[:type], file[:file_type])
      end
    else
      coupon = create_coupon!(coupon_tour)
      create_coupons_prefecture!(coupon)
      create_tours_coupons!(tour_coupon, coupon)
      upload_multiple_file(coupon, params[:file][:url], params[:file][:type], params[:file][:file_type])
    end
  end

  def coupon_params
    params.permit(:start_time, :end_time, :publish_date, :is_notice, prefecture_ids: [])
  end

  def tour_coupon_params
    params.permit(:start_time, :end_time, :name, :code)
  end

  def coupon_tour_params
    params.permit(:start_time, :end_time, :publish_date)
  end
end

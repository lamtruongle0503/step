# frozen_string_literal: true

class Admin::CouponOperations::Update < ApplicationOperation
  attr_reader :coupon_tour, :tour_coupon

  def initialize(actor, params)
    super
    @tour_coupon = TourCoupon.find_by(code: params[:code])
    @coupon_tour = CouponTour.find(params[:id])
  end

  def call
    authorize Coupon
    CouponContracts::Update.new(coupon_params.merge(prefecture_ids: params[:prefecture_ids])).valid!
    ActiveRecord::Base.transaction do
      create_or_update_tour!
      update_coupon_tour!
      update_coupon!
      update_tour_coupons!(tour_coupon)
      update_tours_prefecture!(tour_coupon)
      update_coupon_tour_prefecture!(coupon_tour)
      remove_coupon!
      upload(coupon_tour)
    end
    coupon_tour.reload
  end

  private

  def create_coupon!(coupon_tour)
    Coupon.create!(coupon_params.merge(coupon_tour: coupon_tour))
  end

  def update_coupon!
    coupon_tour.coupons.each do |coupon|
      coupon.update!(coupon_params.merge(updated_at: Time.zone.now))
      update_coupons_prefecture!(coupon)
    end
  end

  def update_coupon_tour!
    coupon_tour.update!(coupon_tour_params.merge(updated_at: Time.zone.now))
  end

  def create_or_update_tour!
    if tour_coupon.present?
      TourCouponContracts::Update.new(
        tour_params.merge(prefecture_ids: params[:prefecture_ids], record: tour_coupon),
      ).valid!
      tour_coupon.update!(tour_params)
    else
      TourCouponContracts::Create.new(tour_params.merge(prefecture_ids: params[:prefecture_ids])).valid!
      @tour_coupon = TourCoupon.create!(tour_params)
    end
  end

  def update_coupons_prefecture!(coupon)
    prefecture_ids = coupon.prefectures.pluck(:id)
    add_prefecture_ids = params[:prefecture_ids] - prefecture_ids
    remove_prefecture_ids = prefecture_ids - params[:prefecture_ids]
    coupon.coupons_prefectures.by_prefecture_ids(remove_prefecture_ids)
          .update_all(deleted_at: Time.zone.now)
    CouponsPrefecture.import! build_coupons_prefecture_create(coupon, add_prefecture_ids)
  end

  def update_coupon_tour_prefecture!(coupon_tour)
    prefecture_ids        = coupon_tour.prefectures.pluck(:id)
    add_prefecture_ids    = params[:prefecture_ids].map(&:to_i) - prefecture_ids
    remove_prefecture_ids = prefecture_ids - params[:prefecture_ids].map(&:to_i)
    coupon_tour.coupon_tour_prefectures.by_prefecture_ids(remove_prefecture_ids)
               .update_all(deleted_at: Time.zone.now)
    CouponTourPrefecture.import! build_coupon_tour_prefecture_create(coupon_tour, add_prefecture_ids)
  end

  def update_tours_prefecture!(tour_coupon)
    prefecture_ids        = tour_coupon.prefectures.pluck(:id)
    add_prefecture_ids    = params[:prefecture_ids] - prefecture_ids
    remove_prefecture_ids = prefecture_ids - params[:prefecture_ids]
    tour_coupon.tours_prefectures.by_prefecture_ids(remove_prefecture_ids)
               .update_all(deleted_at: Time.zone.now)
    ToursPrefecture.import! build_tours_prefecture_create(tour_coupon, add_prefecture_ids)
  end

  def build_tours_prefecture_create(tour_coupon, add_ids)
    add_ids.map { |prefecture_id| { tour_coupon_id: tour_coupon.id, prefecture_id: prefecture_id } }
  end

  def build_coupons_prefecture_create(coupon, add_ids)
    add_ids.map { |prefecture_id| { coupon_id: coupon.id, prefecture_id: prefecture_id } }
  end

  def build_coupon_tour_prefecture_create(coupon_tour, add_ids)
    add_ids.map { |prefecture_id| { coupon_tour_id: coupon_tour.id, prefecture_id: prefecture_id } }
  end

  def remove_coupon!
    return coupon_tour.coupons.update_all(deleted_at: Time.zone.now) if params[:coupon_ids].blank?

    coupon_ids = coupon_tour.coupons.pluck(:id)
    remove_coupon_ids = coupon_ids - params[:coupon_ids]&.map(&:to_i)
    Coupon.where(id: remove_coupon_ids).update_all(deleted_at: Time.zone.now)
  end

  def create_coupons_prefecture!(coupon)
    params[:prefecture_ids].each do |prefecture_id|
      coupon.coupons_prefectures.create(prefecture_id: prefecture_id)
    end
  end

  def create_tours_coupons!(tour_coupon, coupon)
    tour_coupon.coupons << coupon
  end

  def upload(coupon_tour)
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
    params.permit(:start_time, :end_time, :publish_date, :is_notice)
  end

  def update_tour_coupons!(tour_coupon)
    return if coupon_tour.tour_coupon.id == tour_coupon.id

    coupon_tour.tour_coupon.destroy if coupon_tour.tour_coupon.coupons.uniq.length == 1
    coupon_tour.coupons.each do |coupon|
      coupon.tours_coupons.update_all(module_id: tour_coupon.id)
    end
    coupon_tour.update(tour_coupon_id: tour_coupon.id)
  end

  def tour_params
    params.permit(:start_time, :end_time, :name, :code)
  end

  def coupon_tour_params
    params.permit(:start_time, :end_time, :publish_date)
  end
end

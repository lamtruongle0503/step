# frozen_string_literal: true

class Admin::HotelOperations::Update < ApplicationOperation
  attr_reader :hotel

  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:id])
  end

  def call
    authorize nil, HotelPolicy

    HotelContracts::Create.new(params_hotel).valid!
    ActiveRecord::Base.transaction do
      hotel.update!(params_hotel)
      update_coupons!(hotel) if params[:coupons].present?
      upload_image_hotel(hotel) if params[:file]
    end
  end

  private

  def params_hotel
    params.permit(:name, :email, :yomigana, :postal_code, :telephone, :web_comm_fee,
                  :address1, :address2, :manager, :contact_info, :representative,
                  :status, :prefecture_id, :area_setting_id, :hotel_category_id,
                  :fax_number, :opening_date, :refurbished_date, :room_total, :manager_info,
                  :reservation_comm_fee, :purchased_fee, :credit_settlement_fee,
                  :pr_desc, :access_desc, :parking_desc, :tax_service, :tax_information,
                  :allow_children, :children_information, :allow_pet, :pet_information, :other_information,
                  :check_in, :check_out, :accommodation_tax_rate,
                  feature_options: %i[
                    parking pickup_service room_service beauty_salon fitness hot_spring natural_hot_spring
                    outdoor_bath big_bathroom private_bathroom sauna bathtub indoor_pool outdoor_pool
                    walk_to_station massage childcare_service people_disabilities walk_to_convenient
                  ],
                  amenity_options: %i[
                    shampoo soap towels sponge toothbrush brush shower_cap hair_dryer shaving shaving_gel
                    bath_additive yukata nightwear bathrobe sliper facial_wash lotion cotton_swab cotton
                    deodorant_spray fridge mini_bar water_heater tea_set tv vod safe_box music_player
                    satellite_broadcast wifi internet computer
                  ],
                  payment_options: %i[visa master jcb amex diners union_pay debit_card no_credit])
  end

  def update_coupons!(object)
    coupon_ids = object.coupons.pluck(:id)
    coupon_params[:coupons].each do |coupon_param|
      if coupon_param[:id].present?
        HotelContracts::CouponContracts::Update.new(coupon_param.merge(coupon_ids: coupon_ids)).valid!
        coupon = Coupon.find(coupon_param[:id])
        coupon.update!(coupon_param)
      else
        object.coupons.create!(coupon_param)
      end
    end
    return unless params[:coupon_delete].present?

    coupons = Coupon.where(id: params[:coupon_delete]).includes(:coupons_modules, :coupons_prefectures,
                                                                :prefectures, :assets_modules, :notification,
                                                                :coupon_users)
    return unless coupons.present?

    coupons.destroy_all
  end

  def coupon_params
    unless params[:coupons]
      raise BadRequestError,
            coupons: I18n.t('models.can_not_blank')
    end

    params.permit(coupons: %i[id price start_time end_time])
  end

  def upload_image_hotel(hotel)
    return unless params[:file].is_a? Array

    if params[:file].empty?
      hotel.assets&.destroy_all
    else
      params[:file].each do |file|
        upload_multiple_file(hotel, file[:url], file[:type], file[:file_type])
      end
    end
  end
end

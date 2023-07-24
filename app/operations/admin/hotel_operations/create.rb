# frozen_string_literal: true

class Admin::HotelOperations::Create < ApplicationOperation
  def call
    authorize nil, HotelPolicy

    HotelContracts::Create.new(params_hotel).valid!
    ActiveRecord::Base.transaction do
      @hotel = Hotel.create!(params_hotel)
      create_coupons!(@hotel) if params[:coupons]
      upload_image_hotel(@hotel)
    end
    @hotel.reload
  end

  private

  def create_coupons!(hotel)
    coupons = []
    coupon_modules = []
    coupon_params[:coupons].each do |coupon_params|
      HotelContracts::CouponContracts::Create.new(coupon_params).valid!
      coupons.push({
                     price:      coupon_params[:price],
                     start_time: coupon_params[:start_time],
                     end_time:   coupon_params[:end_time],
                   })
    end
    hotel_coupons = hotel.coupons.import!(coupons)
    hotel_coupons.ids.each do |hotel_coupon_id|
      coupon_modules.push({
                            module_type: Hotel.name,
                            module_id:   hotel.id,
                            coupon_id:   hotel_coupon_id,
                          })
    end
    CouponsModule.import!(coupon_modules)
  end

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

  def coupon_params
    unless params[:coupons]
      raise BadRequestError,
            coupons: I18n.t('models.can_not_blank')
    end

    params.permit(coupons: %i[price start_time end_time])
  end

  def upload_image_hotel(hotel)
    raise BadRequestError, images: I18n.t('models.can_not_blank') unless params[:file]
    raise BadRequestError, images: I18n.t('hotels.images_must_be_an_array') unless params[:file].is_a? Array

    params[:file].each do |file|
      raise BadRequestError, images_url: I18n.t('models.can_not_blank') unless file[:url]
      raise BadRequestError, images_type: I18n.t('models.can_not_blank') unless file[:type]
      raise BadRequestError, images_file_type: I18n.t('models.can_not_blank') unless file[:file_type]

      upload_multiple_file(hotel, file[:url], file[:type], file[:file_type])
    end
  end
end

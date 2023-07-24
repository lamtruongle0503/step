# frozen_string_literal: true

class Admin::Tours::ShowSerializer < Admin::Tours::AttributesSerializer
  attributes :destination, :discount, :start_time, :end_time, :exp_point_bonus, :exp_point_receive,
             :first_row_seat_price, :two_rows_seat_price, :regular_seat_price, :tax, :hostel_list,
             :is_show_guide, :meal_description, :note, :options, :point_bonus_rate, :point_receive_rate,
             :scheduler, :sight_seeing, :stayed_nights, :title, :tour_guide, :type_locate, :asset_videos,
             :asset_images, :stop_locations, :hostel_ids, :hotel_description, :tour_hostel_departures,
             :info_travel_fee, :transport_used, :plan_implement, :min_number_participant, :other_fee,
             :coupons, :coupons_available, :stopover

  belongs_to :tour_category, serializer: Admin::Tours::Categories::AttributesSerializer
  belongs_to :company_staff, serializer: Admin::Permissions::Staffs::Tours::AttributesSerializer
  belongs_to :tour_company, serializer: Admin::Tours::Companies::Tours::AttributesSerializer

  has_one :tour_information, serializer: Admin::Tours::Informations::AttributesSerializer
  has_many :tour_start_locations, serializer: Admin::Tours::StartLocations::AttributesSerializer
  belongs_to :tour_cancellation_policy, serializer: Admin::Tours::CancellationPolicies::AttributesSerializer
  has_many :tour_special_foods, serializer: Admin::Tours::SpecialFoods::AttributesSerializer
  has_many :tour_options, serializer: Admin::Tours::Options::AttributesSerializer
  has_many :tour_stay_departures, serializer: Admin::Tours::StayDepartures::AttributesSerializer
  has_many :tour_order_specials, serializer: Admin::Tours::OrderSpecials::AttributesSerializer
  has_many :payments, serializer: Admin::Payments::AttributesSerializer

  def tour_hostel_departures
    return unless object.hostel_departures

    object.hostel_departures.map do |tour_hostel_departure|
      Admin::Tours::HostelDepartures::AttributesSerializer.new(tour_hostel_departure).as_json
    end
  end

  def asset_videos
    object.assets.select { |asset_video| asset_video.type == 't_video_intro' }
  end

  def asset_images
    object.assets.select { |asset_image| asset_image.type == 't_image_intro' }
  end

  def hostel_ids
    object.hostel_departures.pluck(:tour_hostel_id).uniq
  end

  def coupons
    coupons = object.coupons.find_coupon_by_tour
    coupons.map { |coupon| Admin::Coupons::Tours::AttributesSerializer.new(coupon).as_json }
  end

  def coupons_available
    coupons_available = object.coupons.tour_available.find_coupon_by_tour
    coupons_available.map do |coupon_available|
      Admin::Coupons::Tours::AttributesSerializer.new(coupon_available).as_json
    end
  end
end

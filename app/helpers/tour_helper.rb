# frozen_string_literal: true

module TourHelper # rubocop:disable Metrics/ModuleLength
  def create_start_locations!(tour, tour_start_location_params)
    TourContracts::TourStartLocationContracts::Create.new(
      tour_start_location_params.merge!(tour_id: tour.id),
    ).valid!
    tour_start_location_params[:depature_time] = nil if tour_start_location_params[:is_setting].present?
    tour_start_location_params[:concentrate_time] = nil if tour_start_location_params[:is_setting].present?
    tour.tour_start_locations.create!(tour_start_location_params)
  end

  def create_special_foods!(tour, tour_special_food)
    TourContracts::SpecialFoodContracts::Create.new(
      tour_special_food.merge(tour_id: tour.id),
    ).valid!
    special_food = tour.tour_special_foods.create!(tour_special_food.except(:file))
    upload_assets_food(tour_special_food, special_food, tour_special_food[:file])
  end

  def create_stay_departure!(tour, tour_stay_departure)
    TourContracts::StayDepartureContracts::Create.new(
      tour_stay_departure.merge(
        tour_id:   tour.id,
        min_price: tour.tour_information.min_price,
        max_price: tour.tour_information.max_price,
      ),
    ).valid!
    tour_stay_departure[:depature_time] = nil if tour_stay_departure[:is_setting].present?
    tour_stay_departure[:concentrate_time] = nil if tour_stay_departure[:is_setting].present?
    tour.tour_stay_departures.create!(tour_stay_departure.merge!(tour_id: tour.id))
  end

  def create_coupon!(tour, coupon)
    TourContracts::CouponContracts::Create.new(
      coupon.merge(tour_id: tour.id),
    ).valid!
    coupon_prefecture = tour.coupons.create!(coupon)
    update_coupons_prefecture!(tour, coupon_prefecture)
  end

  def create_hostel_departure!(tour, tour_hostel_departure)
    TourContracts::HostelDepartureContracts::Create.new(
      tour_hostel_departure.merge(tour_id: tour.id),
    ).valid!
    tour.hostel_departures.create!(tour_hostel_departure)
  end

  def create_tour_option!(tour, tour_option)
    TourContracts::TourOptionContracts::Create.new(
      tour_option.merge(tour_id: tour.id),
    ).valid!
    option = tour.tour_options.create!(tour_option.except(:file))
    upload_assets_option(tour_option, option, tour_option[:file])
  end

  def update_coupons_prefecture!(tour, coupon)
    current_prefecture_ids = coupon.prefectures.pluck(:id)
    tour_prefecture_ids = tour.tour_start_locations.pluck(:prefecture_id).uniq
    add_prefecture_ids = tour_prefecture_ids - current_prefecture_ids
    remove_prefecture_ids = current_prefecture_ids - tour_prefecture_ids
    coupon.coupons_prefectures.by_prefecture_ids(remove_prefecture_ids)
          .update_all(deleted_at: Time.zone.now)
    CouponsPrefecture.import! build_coupons_prefecture_create(coupon, add_prefecture_ids)
  end

  def build_coupons_prefecture_create(coupon, prefecture_ids)
    prefecture_ids.map { |prefecture_id| { coupon_id: coupon.id, prefecture_id: prefecture_id } }
  end

  def update_coupon_tour_prefecture!(coupon_tour)
    current_prefecture_ids = coupon_tour.prefectures.pluck(:id)
    tour_prefecture_ids = tour.tour_start_locations.pluck(:prefecture_id).uniq
    add_prefecture_ids    = tour_prefecture_ids.map(&:to_i) - current_prefecture_ids
    remove_prefecture_ids = current_prefecture_ids - tour_prefecture_ids.map(&:to_i)
    coupon_tour.coupon_tour_prefectures.by_prefecture_ids(remove_prefecture_ids)
               .update_all(deleted_at: Time.zone.now)
    CouponTourPrefecture.import! build_coupon_tour_prefecture_create(coupon_tour, add_prefecture_ids)
  end

  def build_coupon_tour_prefecture_create(coupon_tour, prefecture_ids)
    prefecture_ids.map { |prefecture_id| { coupon_tour_id: coupon_tour.id, prefecture_id: prefecture_id } }
  end

  def upload_assets_food(tour_special_food, special_food, files)
    return unless tour_special_food[:file].is_a? Array

    files.each do |file|
      upload_multiple_file(special_food, file[:url], file[:type], file[:file_type])
    end
  end

  def upload_assets_option(tour_option, option, files)
    return unless tour_option[:file].is_a? Array

    files.each do |file|
      upload_multiple_file(option, file[:url], file[:type], file[:file_type])
    end
  end

  def upload_assets_tour!(tour)
    return unless params[:file].is_a? Array

    params[:file].each do |file|
      upload_multiple_file(tour, file[:url], file[:type], file[:file_type])
    end
  end

  def tour_status(status)
    case status
    when Tour::POSTED
      '掲載中'
    when Tour::NO_POSTED
      '非掲載'
    when Tour::ENDED
      '終了'
    end
  end

  def search_tour_near_user(actor, type_locate)
    return [] unless actor&.post_code.present?

    user_prefecture = ZipCodeJp.find(actor.post_code)
    @tours = if user_prefecture.present?
               Tour.by_end_date_and_status_posted.by_prefecture_name(type_locate, user_prefecture&.prefecture)
                   .ransack(params[:q]).result(distinct: true).newest
             else
               []
             end
  end
end

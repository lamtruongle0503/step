# frozen_string_literal: true

namespace :db do
  task migrate_coupons: :environment do
    ActiveRecord::Base.transaction do
      coupons_by_tours
    end
  end

  private

  def coupons_by_tours
    Tour.all.each do |tour|
      next if tour.coupons.blank?

      coupon_tour = create_tour_coupon(tour.start_time, tour.end_time, tour.coupons.first&.publish_date,
                                       tour.id, tour.updated_at, tour.coupons.first&.created_at)
      tour.coupons.each do |coupon|
        if coupon.assets.size >= 2
          coupon.assets.each do |asset|
            new_coupon = coupon_tour.coupons.create!(start_time:   coupon.start_time,
                                                     end_time:     coupon.end_time,
                                                     publish_date: coupon.publish_date,
                                                     created_at:   coupon.created_at)
            new_coupon.assets.create(url: asset.url)
          end
          coupon.destroy!
        end
        coupon.update!(coupon_tour: coupon_tour)
      end
      create_coupon_tour_prefecture(coupon_tour, tour.prefectures.pluck(:id).uniq)
    end
  end

  def create_tour_coupon(start_time, end_time, publish_date, tour_id, updated_at, created_at) # rubocop:disable Metrics/ParameterLists
    CouponTour.create!(start_time: start_time, end_time: end_time, publish_date: publish_date,
                       tour_id: tour_id, updated_at: updated_at, created_at: created_at)
  end

  def create_coupon_tour_prefecture(coupon_tour, prefecture_ids)
    prefecture_ids.each do |prefecture_id|
      CouponTourPrefecture.create(coupon_tour_id: coupon_tour.id, prefecture_id: prefecture_id)
    end
  end
end

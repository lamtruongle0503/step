# == Schema Information
#
# Table name: coupons
#
#  id             :bigint           not null, primary key
#  deleted_at     :datetime
#  end_time       :date
#  is_notice      :boolean
#  price          :float
#  publish_date   :date
#  start_time     :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  coupon_tour_id :bigint
#
# Indexes
#
#  index_coupons_on_coupon_tour_id  (coupon_tour_id)
#
class Coupon < ApplicationRecord
  acts_as_paranoid

  has_many :coupons_modules, dependent: :destroy
  has_many :tours, source: :module, source_type: Tour.name, through: :coupons_modules
  has_many :tour_coupons, source: :module, source_type: TourCoupon.name, through: :coupon_modules
  has_many :coupons_prefectures, dependent: :destroy
  has_many :prefectures, through: :coupons_prefectures, dependent: :destroy
  has_many :assets_modules, as: :module, dependent: :destroy
  has_many :assets, through: :assets_modules
  has_one :notification, as: :module, dependent: :destroy
  has_many :products, source: :module, source_type: Product.name, through: :coupons_modules

  has_many :tours_coupons, -> { is_tours }, class_name: CouponsModule.name
  has_many :coupon_users, dependent: :destroy
  has_many :ecommerce_coupon_users

  belongs_to :coupon_tour, optional: true, class_name: CouponTour.name

  scope :available, lambda {
    joins(:coupon_tour).where(
      ':date BETWEEN coupon_tours.start_time AND coupon_tours.end_time', date: Date.current
    )
  }

  scope :ec_available, lambda {
    where(':date BETWEEN start_time AND end_time', date: Date.current)
  }

  scope :tour_available, lambda {
    where(':date BETWEEN start_time AND end_time', date: Date.current)
  }

  scope :find_coupon_by_type_coupon_of_coupon_tour, lambda {
    joins(:coupon_tour).where(
      'coupon_tours.type_coupon = ?', CouponTour.type_coupons[CouponTour::STORE_COUPON]
    )
  }

  scope :find_coupon_by_tour, lambda {
    where('coupon_tour_id IS NULL')
  }

  scope :coupon_no_expiration, lambda {
    where('? BETWEEN DATE(coupons.start_time) AND DATE(coupons.end_time)', Time.now.to_date)
  }

  ransacker :start_time, type: :date do
    Arel.sql 'DATE(coupons.start_time)'
  end

  ransacker :end_time, type: :date do
    Arel.sql 'DATE(coupons.end_time)'
  end
end

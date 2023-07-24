# == Schema Information
#
# Table name: coupon_tours
#
#  id             :bigint           not null, primary key
#  deleted_at     :datetime
#  end_time       :date
#  publish_date   :date
#  start_time     :date
#  type_coupon    :integer          default("tour_coupon")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  tour_coupon_id :integer
#  tour_id        :bigint
#
# Indexes
#
#  index_coupon_tours_on_tour_id  (tour_id)
#
class CouponTour < ApplicationRecord
  acts_as_paranoid

  has_many :coupons, dependent: :destroy
  has_many :coupon_tour_prefectures, dependent: :destroy
  has_many :prefectures, through: :coupon_tour_prefectures
  belongs_to :tour_coupon
  belongs_to :tour, optional: true

  TOUR_COUPON  = 'tour_coupon'.freeze
  STORE_COUPON = 'store_coupon'.freeze

  enum type_coupon: { tour_coupon: 0, store_coupon: 1 }
end

# == Schema Information
#
# Table name: tour_coupons
#
#  id         :bigint           not null, primary key
#  code       :string
#  deleted_at :datetime
#  end_time   :date
#  name       :string
#  start_time :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TourCoupon < ApplicationRecord
  acts_as_paranoid

  has_many :coupons_modules, as: :module, dependent: :destroy
  has_many :coupons, through: :coupons_modules, dependent: :destroy
  has_many :tours_prefectures, dependent: :destroy
  has_many :prefectures, through: :tours_prefectures, dependent: :destroy

  scope :not_expired, ->(date) { where('end_time >= ?', date) }
end

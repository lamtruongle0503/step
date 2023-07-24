# == Schema Information
#
# Table name: prefectures
#
#  id                  :bigint           not null, primary key
#  deleted_at          :datetime
#  name                :string
#  prefecture_jis_code :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  area_setting_id     :bigint
#  location_area_id    :integer
#
# Indexes
#
#  index_prefectures_on_area_setting_id  (area_setting_id)
#
# Foreign Keys
#
#  fk_rails_...  (area_setting_id => area_settings.id)
#
class Prefecture < ApplicationRecord
  acts_as_paranoid

  has_many :coupons, through: :coupons_prefectures
  has_many :tours_prefectures, dependent: :destroy
  has_many :coupon_tour_prefectures, dependent: :destroy
  has_many :tours, through: :tours_prefectures
  has_many :tour_coupons, through: :tours_prefectures
  has_one :user_prefecture, dependent: :destroy
  belongs_to :area_setting, optional: true
  has_many :districts, dependent: :destroy
  has_one :coordinate, as: :module
  has_many :weather_reports, dependent: :destroy
  has_many :tour_start_locations, dependent: :destroy, class_name: 'Tour::StartLocation'
  has_many :tour_stay_departures, dependent: :destroy, class_name: 'Tour::StayDeparture'
  has_many :tour_place_starts, dependent: :destroy, class_name: 'Tour::PlaceStart'

  scope :find_by_area_setting, lambda { |area_setting_id|
    return unless area_setting_id

    where(area_setting_id: area_setting_id)
  }
end

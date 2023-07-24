# == Schema Information
#
# Table name: tour_stay_departures
#
#  id                  :bigint           not null, primary key
#  address             :string
#  code                :string
#  concentrate_time    :string
#  depature_time       :string
#  four_person_fee     :float
#  is_setting          :boolean          default(FALSE)
#  name                :string
#  one_person_fee      :integer
#  setting_date        :date
#  three_person_fee    :float
#  two_person_fee      :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  prefecture_id       :integer
#  tour_id             :bigint
#  tour_place_start_id :bigint
#
# Indexes
#
#  index_tour_stay_departures_on_tour_id              (tour_id)
#  index_tour_stay_departures_on_tour_place_start_id  (tour_place_start_id)
#
# Foreign Keys
#
#  fk_rails_...  (tour_id => tours.id)
#
class Tour::StayDeparture < ApplicationRecord
  belongs_to :tour, foreign_key: :tour_id, class_name: 'Tour'
  belongs_to :prefecture
  belongs_to :tour_place_start, foreign_key: :tour_place_start_id, class_name: 'Tour::PlaceStart'
  has_many :tour_bus_infos, dependent: :destroy, class_name: 'Tour::BusInfo',
  foreign_key: :tour_stay_departure_id

  scope :by_setting_date, ->(setting_date) { where(setting_date: setting_date) }

  scope :available, lambda {
    joins(:tour).where(':date BETWEEN tours.start_date AND tours.end_date', date: Date.current)
  }
end

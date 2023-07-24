# == Schema Information
#
# Table name: tour_place_starts
#
#  id            :bigint           not null, primary key
#  code          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  prefecture_id :bigint
#  tour_id       :bigint
#
# Indexes
#
#  index_tour_place_starts_on_prefecture_id  (prefecture_id)
#  index_tour_place_starts_on_tour_id        (tour_id)
#
# Foreign Keys
#
#  fk_rails_...  (prefecture_id => prefectures.id)
#  fk_rails_...  (tour_id => tours.id)
#
class Tour::PlaceStart < ApplicationRecord
  belongs_to :tour, foreign_key: :tour_id, class_name: 'Tour'
  belongs_to :prefecture
  has_many :tour_stay_departures, dependent: :destroy, class_name: 'Tour::StayDeparture',
foreign_key: :tour_place_start_id
  has_many :tour_start_locations, dependent: :destroy, class_name: 'Tour::StartLocation',
foreign_key: :tour_place_start_id
  has_many :tour_bus_infos, dependent: :destroy, class_name: 'Tour::BusInfo',
foreign_key: :tour_place_start_id
end

# == Schema Information
#
# Table name: tour_bus_infos
#
#  id                     :bigint           not null, primary key
#  available_seats        :integer
#  bus_no                 :string
#  concentrate_time       :string
#  day_of_week            :string
#  departure_date         :date
#  departure_time         :string
#  is_weekend             :integer          default("day_off")
#  operation_status       :string
#  reserved_seats         :integer
#  seats_map              :jsonb
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  tour_bus_pattern_id    :bigint           not null
#  tour_id                :bigint           not null
#  tour_place_start_id    :bigint
#  tour_start_location_id :integer
#  tour_stay_departure_id :integer
#
# Indexes
#
#  index_tour_bus_infos_on_tour_bus_pattern_id  (tour_bus_pattern_id)
#  index_tour_bus_infos_on_tour_id              (tour_id)
#  index_tour_bus_infos_on_tour_place_start_id  (tour_place_start_id)
#
# Foreign Keys
#
#  fk_rails_...  (tour_bus_pattern_id => tour_bus_patterns.id)
#  fk_rails_...  (tour_id => tours.id)
#
class Tour::BusInfo < ApplicationRecord
  belongs_to :tour_bus_pattern, foreign_key: :tour_bus_pattern_id, class_name: 'Tour::BusPattern'
  belongs_to :tour, foreign_key: :tour_id, class_name: 'Tour'
  belongs_to :tour_start_location, foreign_key: :tour_start_location_id, class_name: 'Tour::StartLocation',
optional: true
  belongs_to :tour_stay_departure, foreign_key: :tour_stay_departure_id, class_name: 'Tour::StayDeparture',
optional: true
  belongs_to :tour_place_start, foreign_key: :tour_place_start_id, class_name: 'Tour::PlaceStart'
  has_many :tour_orders, foreign_key: :tour_bus_info_id, class_name: 'Tour::Order', dependent: :destroy

  DAYOFF = 'day_off'.freeze
  WEEKDAY = 'weekday'.freeze
  ALL_DAY = 'all_day'.freeze
  OPEN = 'open'.freeze
  BOOKING = 'booking'.freeze
  NORMAL = 'normal'.freeze
  HIDE = 'hide'.freeze
  WOMEN = 'women'.freeze
  UNAVAILABE = 'unavailable'.freeze

  enum is_weekend: { day_off: 0, weekday: 1, all_day: 2 }
  enum status: { open: 0, booking: 1 }
  enum type: { normal: 0, women: 1, hide: 2, unavailable: 3 }

  scope :by_departure_date, ->(departure_date) { where(departure_date: departure_date) }
  scope :by_departure_date_asc, -> { order(departure_date: :asc) }
  scope :sorted_by, ->(field, order) { order("#{field} #{order}") }
end

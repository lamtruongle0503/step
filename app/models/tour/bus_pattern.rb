# == Schema Information
#
# Table name: tour_bus_patterns
#
#  id         :bigint           not null, primary key
#  capacity   :integer
#  map        :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tour::BusPattern < ApplicationRecord
  serialize :map, Array

  has_many :bus_infos, class_name: 'Tour::BusInfo', foreign_key: 'tour_bus_pattern_id', dependent: :destroy

  OPEN = 'open'.freeze
  BOOKING = 'booking'.freeze
  NORMAL = 'normal'.freeze
  HIDE = 'hide'.freeze
  WOMEN = 'women'.freeze
  UNAVAILABE = 'unavailable'.freeze

  enum status: { open: 0, booking: 1 }
  enum type: { normal: 0, women: 1, hide: 2, unavailable: 3 }

  scope :find_bus_pattern_by_map, -> { where.not('map IS NULL') }
end

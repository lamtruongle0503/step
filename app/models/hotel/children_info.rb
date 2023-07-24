# == Schema Information
#
# Table name: hotel_children_infos
#
#  id         :bigint           not null, primary key
#  capacity   :integer
#  code       :string
#  deleted_at :datetime
#  fee        :bigint           default(0)
#  is_accept  :integer          default("non_accept")
#  name       :string
#  unit       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  hotel_id   :bigint
#
# Indexes
#
#  index_hotel_children_infos_on_hotel_id  (hotel_id)
#
# Foreign Keys
#
#  fk_rails_...  (hotel_id => hotels.id)
#
class Hotel::ChildrenInfo < ApplicationRecord
  acts_as_paranoid

  belongs_to :hotel, foreign_key: :hotel_id

  NON_ACCEPT = 'non_accept'.freeze
  ACCEPT_WITH_ADULT = 'accept_with_adult'.freeze
  ACCEPT = 'accept'.freeze
  INCLUDE = 'include'.freeze
  EXCLUDE = 'exclude'.freeze
  PERCENT = 'percent'.freeze
  JPY = 'jpy'.freeze

  enum is_accept: { non_accept: 0, accept_with_adult: 1, accept: 2 }
  enum capacity: { include: 0, exclude: 1 }
  enum unit: { percent: 0, jpy: 1 }
end

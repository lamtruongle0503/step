# == Schema Information
#
# Table name: hotel_requests
#
#  id            :bigint           not null, primary key
#  check_in      :date
#  check_out     :date
#  comments      :string
#  deleted_at    :datetime
#  email         :string
#  full_name     :string
#  phone_number  :string
#  request_no    :string
#  room_type     :integer
#  status        :integer          default("no_resolve")
#  total_person  :integer
#  total_room    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  hotel_id      :bigint
#  hotel_plan_id :bigint
#  hotel_room_id :bigint
#
# Indexes
#
#  index_hotel_requests_on_hotel_id       (hotel_id)
#  index_hotel_requests_on_hotel_plan_id  (hotel_plan_id)
#  index_hotel_requests_on_hotel_room_id  (hotel_room_id)
#
# Foreign Keys
#
#  fk_rails_...  (hotel_id => hotels.id)
#  fk_rails_...  (hotel_plan_id => hotel_plans.id)
#  fk_rails_...  (hotel_room_id => hotel_rooms.id)
#
class Hotel::Request < ApplicationRecord
  acts_as_paranoid

  belongs_to :hotel
  belongs_to :hotel_plan, class_name: 'Hotel::Plan'
  belongs_to :hotel_room, class_name: 'Hotel::Room'

  # Room Type
  SINGLE = 'single'.freeze
  DOUBLE = 'double'.freeze
  TWIN = 'twin'.freeze
  DOUBLE_TWIN = 'double_twin'.freeze

  # Status
  NO_RESOLVE = 'no_resolve'.freeze
  RESOLVE = 'resolved'.freeze

  enum room_type: { single: 0, double: 1, twin: 2, double_twin: 3 }
  enum status: { no_resolve: 0, resolved: 1 }
end

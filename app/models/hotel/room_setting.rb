# == Schema Information
#
# Table name: hotel_room_settings
#
#  id                   :bigint           not null, primary key
#  date                 :date
#  deleted_at           :datetime
#  eight_person_fee     :bigint           default(0)
#  five_people_fee      :bigint           default(0)
#  four_people_fee      :bigint           default(0)
#  nine_person_fee      :bigint           default(0)
#  one_person_fee       :bigint           default(0)
#  remain_room          :integer
#  reservation_number   :integer
#  seven_person_fee     :bigint           default(0)
#  six_person_fee       :bigint           default(0)
#  status               :integer          default("open")
#  ten_person_fee       :bigint           default(0)
#  three_people_fee     :bigint           default(0)
#  two_people_fee       :bigint           default(0)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  hotel_plan_id        :bigint           not null
#  hotel_plan_option_id :bigint
#  hotel_room_id        :bigint           not null
#
# Indexes
#
#  index_hotel_room_settings_on_hotel_plan_id         (hotel_plan_id)
#  index_hotel_room_settings_on_hotel_plan_option_id  (hotel_plan_option_id)
#  index_hotel_room_settings_on_hotel_room_id         (hotel_room_id)
#
# Foreign Keys
#
#  fk_rails_...  (hotel_plan_id => hotel_plans.id)
#  fk_rails_...  (hotel_plan_option_id => hotel_plan_options.id)
#  fk_rails_...  (hotel_room_id => hotel_rooms.id)
#
class Hotel::RoomSetting < ApplicationRecord
  acts_as_paranoid

  belongs_to :hotel_plan, class_name: 'Hotel::Plan', foreign_key: :hotel_plan_id
  belongs_to :hotel_room, class_name: 'Hotel::Room', foreign_key: :hotel_room_id
  belongs_to :hotel_plan_option, class_name: 'Hotel::PlanOption', foreign_key: :hotel_plan_option_id

  scope :month_of_callendar, lambda { |room_id, date_start, date_end|
    where("hotel_room_settings.hotel_room_id = #{room_id} AND (date BETWEEN '#{date_start}' AND '#{date_end}') AND hotel_room_settings.status = #{Hotel::RoomSetting.statuses[:open]}")
  }
  scope :date_order, lambda { |room_id, check_in, check_out|
                       where(hotel_room_id: room_id, date: check_in..check_out)
                     }

  # Status
  OPEN = 'open'.freeze
  CLOSE = 'close'.freeze
  enum status: { open: 0, close: 1 }
end

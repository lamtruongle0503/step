# == Schema Information
#
# Table name: hotel_rooms
#
#  id               :bigint           not null, primary key
#  capacity         :integer
#  deleted_at       :datetime
#  description      :string
#  floor_number     :integer
#  floor_plan       :string
#  floor_type       :integer          default("normally")
#  is_show          :boolean          default(FALSE)
#  is_smoking       :integer          default("smoking")
#  management_name  :string
#  name             :string
#  number_children  :integer
#  room_type        :integer          default("single")
#  setting_date     :date
#  square_meter_max :float
#  square_meter_min :float
#  total_floor_max  :bigint
#  total_floor_min  :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  hotel_id         :bigint
#
# Indexes
#
#  index_hotel_rooms_on_hotel_id  (hotel_id)
#
# Foreign Keys
#
#  fk_rails_...  (hotel_id => hotels.id)
#
class Hotel::Room < ApplicationRecord
  acts_as_paranoid

  belongs_to :hotel, foreign_key: :hotel_id
  has_many :assets_modules, as: :module, dependent: :destroy
  has_many :assets, through: :assets_modules
  has_many :hotel_room_settings, class_name: 'Hotel::RoomSetting', foreign_key: :hotel_room_id
  has_many :hotel_plans, through: :hotel_room_settings

  NORMALLY = 'normally'.freeze
  CLUB = 'club'.freeze
  SMOKING = 'smoking'.freeze
  NON_SMOKING = 'non_smoking'.freeze
  DEODORANT_SUPPORT = 'deodorant_support'.freeze
  SINGLE = 'single'.freeze
  DOUBLE = 'double'.freeze
  TWIN = 'twin'.freeze
  DOUBLE_TWIN = 'double_twin'.freeze

  enum floor_type: { normally: 0, club: 1 }
  enum is_smoking: { smoking: 0, non_smoking: 1, deodorant_support: 2 }
  enum room_type: { single: 0, double: 1, twin: 2, double_twin: 3 }

  scope :setting_show, -> { where(is_show: true) }

  scope :show_room_plans, lambda { |capacity, setting_children, number_children|
    where(<<-SQL.strip_heredoc)
      is_show = true
      AND capacity >= #{capacity}
      AND number_children #{setting_children == 1 ? '>=' : '='} #{number_children}
    SQL
  }
end

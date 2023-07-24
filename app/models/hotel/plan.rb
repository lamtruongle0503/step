# == Schema Information
#
# Table name: hotel_plans
#
#  id                           :bigint           not null, primary key
#  check_in                     :string
#  check_out                    :string
#  credit_card_transaction_fee  :bigint
#  day_hidden                   :bigint
#  deleted_at                   :datetime
#  end_stay_date                :date
#  exp_point_bonus              :integer          default(1)
#  exp_point_receive            :bigint
#  from_night                   :bigint
#  from_room                    :bigint
#  is_sale_off                  :integer
#  is_use_coupon                :boolean          default(FALSE)
#  management_name              :string
#  name                         :string
#  option_ids                   :string           default([]), is an Array
#  payments                     :string           default([]), is an Array
#  point_bonus                  :integer
#  point_receive                :bigint
#  rate_type                    :bigint
#  room_limit                   :bigint
#  setting_check_in_out         :integer
#  setting_children             :integer
#  setting_limit                :integer
#  setting_limit_room           :integer
#  setting_number_night_stay    :integer
#  setting_payments             :string
#  setting_sale_off             :string           default([]), is an Array
#  setting_show                 :integer          default("hide")
#  settlement_date              :bigint
#  settlement_time              :string
#  start_stay_date              :date
#  to_night                     :bigint
#  to_room                      :bigint
#  type_meal                    :string           default([]), is an Array
#  type_plan                    :integer          default("buy")
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  hotel_cancellation_policy_id :bigint
#  hotel_id                     :bigint
#  hotel_meal_id                :integer
#
# Indexes
#
#  index_hotel_plans_on_hotel_cancellation_policy_id  (hotel_cancellation_policy_id)
#  index_hotel_plans_on_hotel_id                      (hotel_id)
#
# Foreign Keys
#
#  fk_rails_...  (hotel_id => hotels.id)
#
class Hotel::Plan < ApplicationRecord
  acts_as_paranoid

  belongs_to :hotel, foreign_key: :hotel_id
  belongs_to :hotel_cancellation_policy, foreign_key: :hotel_cancellation_policy_id,
                                         class_name:  'Hotel::CancellationPolicy'
  has_many :assets_modules, as: :module, dependent: :destroy
  has_many :assets, through: :assets_modules
  has_one :hotel_plan_option, dependent: :destroy, foreign_key: :hotel_plan_id,
           class_name: 'Hotel::PlanOption'
  has_many :hotel_room_settings, foreign_key: :hotel_plan_id, dependent: :destroy,
           class_name: 'Hotel::RoomSetting'
  has_many :hotel_rooms, through: :hotel_room_settings
  belongs_to :hotel_meal, foreign_key: :hotel_meal_id, class_name: 'Hotel::Meal'
  has_many :hotel_plan_childrens, foreign_key: :hotel_plan_id, class_name: 'Hotel::PlanChildren'
  has_many :children_infos, through: :hotel_plan_childrens, source: :hotel_children_info, dependent: :destroy
  has_many :hotel_orders, dependent: :destroy, class_name: 'Hotel::Order', foreign_key: :hotel_plan_id

  scope :search_in_number_night, lambda { |number_night|
    where("(hotel_plans.setting_number_night_stay = #{Hotel::Plan.setting_number_night_stays[:unlimited_night]}) OR (hotel_plans.setting_number_night_stay = #{Hotel::Plan.setting_number_night_stays[:setting_night]} AND (#{number_night} BETWEEN hotel_plans.from_night AND hotel_plans.to_night))")
  }
  scope :setting_show, lambda {
    where('(hotel_plans.setting_show = ?)
           OR ((hotel_plans.setting_show =  ?)
                AND (hotel_plans.day_hidden >= (date(?) - date(hotel_plans.created_at))))',
          Hotel::Plan.setting_shows[Hotel::Plan::SHOW],
          Hotel::Plan.setting_shows[Hotel::Plan::SETTING_DATE],
          Time.zone.now.to_date)
  }

  # setting children
  IMPOSSIBLE = 'impossible'.freeze
  POSSIBLE = 'possible'.freeze

  # sale off
  NO_SET = 'no_set'.freeze
  SET = 'set'.freeze

  # type plan
  BUY = 'buy'.freeze
  CONSIGNMENT = 'consignment'.freeze
  REQUEST = 'request'.freeze

  # Setting room
  UNLIMITED_ROOM = 'unlimited_room'.freeze
  SETTING_ROOM = 'setting_room'.freeze

  # Setting show
  HIDE = 'hide'.freeze
  SHOW = 'show'.freeze
  SETTING_DATE = 'setting_date'.freeze

  # Payment
  ON_SPOT = 'on_spot'.freeze
  CREDIT_CARD = 'credit_card'.freeze

  # Setting limit
  UNLIMITED = 'unlimited'.freeze
  EACH_DAY = 'each_day'.freeze
  SETTING_NUMBER_ROOM = 'setting_number_room'.freeze

  # Setting number night stay
  UNLIMITED_NIGHT = 'unlimited_night'.freeze
  SETTING_NIGHT = 'setting_night'.freeze

  # Setting check in out
  BASIC = 'basic'.freeze
  PLAN = 'plan'.freeze

  enum type_plan: { buy: 0, consignment: 1, request: 2 }
  enum setting_show: { hide: 0, show: 1, setting_date: 2 }
  enum meals: { no_meal: 0, breakfast: 1, dinner: 2, breakfast_and_dinner: 3, breakfast_and_lunch: 4,
                    lunch: 5, lunch_and_dinner: 6, all_meal: 7 }
  enum method_payments: { on_spot: 0, credit_card: 1 }
  enum setting_limit: { unlimited: 0, each_day: 1, setting_number_room: 3 }
  enum setting_number_night_stay: { unlimited_night: 0, setting_night: 1 }
  enum setting_limit_room: { unlimited_room: 0, setting_room: 1 }
  enum is_sale_off: { no_set: 0, set: 1 }
  enum setting_check_in_out: { basic: 0, plan: 1 }
  enum setting_children: { impossible: 0, possible: 1 }

  ransack_alias :remain_room, :hotel_room_settings_remain_room
  ransack_alias :capacity, :hotel_room_settings_hotel_room_capacity
end

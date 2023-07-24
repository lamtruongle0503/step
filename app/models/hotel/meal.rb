# == Schema Information
#
# Table name: hotel_meals
#
#  id              :bigint           not null, primary key
#  address         :string
#  deleted_at      :datetime
#  description     :string
#  end_time        :string
#  is_used         :boolean          default(FALSE)
#  management_name :string
#  name            :string
#  start_time      :string
#  type            :integer          default("no_meal")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  hotel_id        :bigint
#
# Indexes
#
#  index_hotel_meals_on_hotel_id  (hotel_id)
#
class Hotel::Meal < ApplicationRecord
  acts_as_paranoid
  self.inheritance_column = :_type_disabled

  belongs_to :hotel, foreign_key: :hotel_id
  has_many :assets_modules, as: :module, dependent: :destroy
  has_many :assets, through: :assets_modules

  NO_MEAL = 'no_meal'.freeze
  BREAKFAST = 'breakfast'.freeze
  DINNER = 'dinner'.freeze
  BREAKFAST_AND_DINNER = 'breakfast_and_dinner'.freeze
  BREAKFAST_AND_LUNCH = 'breakfast_and_lunch'.freeze
  LUNCH = 'lunch'.freeze
  LUNCH_AND_DINNER = 'lunch_and_dinner'.freeze
  THREE_MEALS = 'three_meals'.freeze
  AVAILABLE = 'available'.freeze
  UNAVAILABLE = 'unavailable'.freeze

  enum type: { no_meal: 0, breakfast: 1, dinner: 2, breakfast_and_dinner: 3,
               breakfast_and_lunch: 4, lunch: 5, lunch_and_dinner: 6, three_meals: 7 }

  scope :use, -> { where(is_used: true) }
end

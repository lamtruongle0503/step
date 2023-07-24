# == Schema Information
#
# Table name: hotel_plan_options
#
#  id              :bigint           not null, primary key
#  deleted_at      :datetime
#  end_date_stay   :date
#  room_ids        :string           default([]), is an Array
#  start_date_stay :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  hotel_meal_id   :bigint
#  hotel_option_id :bigint
#  hotel_plan_id   :bigint
#
# Indexes
#
#  index_hotel_plan_options_on_hotel_meal_id    (hotel_meal_id)
#  index_hotel_plan_options_on_hotel_option_id  (hotel_option_id)
#  index_hotel_plan_options_on_hotel_plan_id    (hotel_plan_id)
#
# Foreign Keys
#
#  fk_rails_...  (hotel_meal_id => hotel_meals.id)
#  fk_rails_...  (hotel_option_id => hotel_options.id)
#  fk_rails_...  (hotel_plan_id => hotel_plans.id)
#
class Hotel::PlanOption < ApplicationRecord
  acts_as_paranoid

  belongs_to :hotel_plan, foreign_key: :hotel_plan_id, class_name: 'Hotel::Plan'
  belongs_to :hotel_meal, foreign_key: :hotel_meal_id, class_name: 'Hotel::Meal'
  has_many :hotel_room_settings, foreign_key: :hotel_plan_option_id, class_name: 'Hotel::RoomSetting',
           dependent: :destroy
end

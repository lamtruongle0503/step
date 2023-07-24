# frozen_string_literal: true

class HotelContracts::PlanOptionContracts::Base < ApplicationContract
  attribute :hotel_meal_id, Integer
  attribute :room_ids, Array
  attribute :hotel_plan_id, Integer

  with_options presence: true do
    validates :hotel_meal_id, existence: Hotel::Meal.name
    validates :room_ids, existences: Hotel::Room.name
    validates :hotel_plan_id, uniqueness: { model: Hotel::PlanOption }
  end
end

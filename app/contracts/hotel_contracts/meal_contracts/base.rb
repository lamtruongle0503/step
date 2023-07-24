# frozen_string_literal: true

class HotelContracts::MealContracts::Base < ApplicationContract
  attribute :address, String
  attribute :description, String
  attribute :start_time, String
  attribute :end_time, String
  attribute :is_used, Boolean
  attribute :management_name, String
  attribute :name, String
  attribute :type, Integer
  attribute :created_at, DateTime
  attribute :updated_at, DateTime
  attribute :hotel_id, Integer

  validate :end_time_must_be_after_start_time
  validates :type, inclusion: { in: Hotel::Meal.types }, if: -> { type }

  def end_time_must_be_after_start_time
    return if end_time.to_time > start_time.to_time

    errors.add(:end_time, I18n.t('hotels.meals.end_time'))
  end
end

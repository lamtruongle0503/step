# frozen_string_literal: true

class TourContracts::TourStartLocationContracts::Base < ApplicationContract
  attribute :name,                String
  attribute :setting_date,        Date
  attribute :depature_time,       String
  attribute :prefecture_id,       Integer
  attribute :tour_id,             Integer
  attribute :concentrate_time,    String
  attribute :is_setting,          Boolean
  attribute :code,                String
  attribute :tour_place_start_id, Integer

  validates :name, presence: true
  validates :setting_date, presence: true
  validates :depature_time, presence: true, unless: -> { is_setting }
  validates :concentrate_time, presence: true, unless: -> { is_setting }
  validates :prefecture_id, presence: true, existence: Prefecture.name
  validates :tour_id, presence: true, existence: Tour.name
  validates :tour_place_start_id, presence: true, existence: Tour::PlaceStart.name
end

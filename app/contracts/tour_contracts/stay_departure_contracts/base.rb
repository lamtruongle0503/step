# frozen_string_literal: true

class TourContracts::StayDepartureContracts::Base < ApplicationContract
  attribute :address,             String
  attribute :concentrate_time,    String
  attribute :depature_time,       String
  attribute :one_person_fee,      Integer
  attribute :two_person_fee,      Integer
  attribute :three_person_fee,    Integer
  attribute :four_person_fee,     Integer
  attribute :tour_id,             Integer
  attribute :setting_date,        Date
  attribute :prefecture_id,       Integer
  attribute :is_setting,          Boolean
  attribute :code,                String
  attribute :tour_place_start_id, Integer
  attribute :min_price,           Integer
  attribute :max_price,           Integer

  validates :tour_id, presence: true, existence: Tour.name
  with_options length:       { maximum: 15 },
               numericality: {
                 only_integer: true, greater_than_or_equal_to: :min_price,
                 less_than_or_equal_to: :max_price
               } do
    validates :one_person_fee
    validates :two_person_fee
    validates :three_person_fee
    validates :four_person_fee
  end

  validates :depature_time, presence: true, unless: -> { is_setting }
  validates :concentrate_time, presence: true, unless: -> { is_setting }
  validates :prefecture_id, presence: true, existence: Prefecture.name
  validates :tour_place_start_id, presence: true, existence: Tour::PlaceStart.name
end

# frozen_string_literal: true

class TourContracts::TourInformationContracts::Base < ApplicationContract
  attribute :adult_amount,              Integer
  attribute :adult_dayoff_discount,     Integer
  attribute :adult_dayoff_price,        Integer
  attribute :adult_weekday_discount,    Integer
  attribute :adult_weekday_price,       Integer
  attribute :baby_amount,               Integer
  attribute :baby_dayoff_discount,      Integer
  attribute :baby_dayoff_price,         Integer
  attribute :baby_weekday_discount,     Integer
  attribute :baby_weekday_price,        Integer
  attribute :children_amount,           Integer
  attribute :children_dayoff_discount,  Integer
  attribute :children_dayoff_price,     Integer
  attribute :children_weekday_discount, Integer
  attribute :children_weekday_price,    Integer
  attribute :max_price,                 Integer
  attribute :min_price,                 Integer
  attribute :tour_id,                   Integer

  validates :tour_id, presence: true, existence: Tour.name
  with_options length: { maximum: 15 } do
    validates :adult_dayoff_discount
    validates :adult_weekday_discount
    validates :baby_dayoff_discount
    validates :baby_weekday_discount
    validates :children_dayoff_discount
    validates :children_weekday_discount
    validates :adult_dayoff_price
    validates :adult_weekday_price
    validates :baby_dayoff_price
    validates :baby_weekday_price
    validates :children_dayoff_price
    validates :children_weekday_price
  end
end

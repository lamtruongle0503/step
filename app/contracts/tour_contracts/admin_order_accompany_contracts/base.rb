# frozen_string_literal: true

class TourContracts::AdminOrderAccompanyContracts::Base < ApplicationContract
  attribute :address1,                    String
  attribute :address2,                    String
  attribute :birth_day,                   Date
  attribute :departure_start_location,    String
  attribute :depature_time,               String
  attribute :email,                       String
  attribute :first_name,                  String
  attribute :first_name_kana,             String
  attribute :full_name,                   String
  attribute :furigana,                    String
  attribute :gender,                      Integer
  attribute :is_owner,                    Boolean
  attribute :is_save,                     Boolean
  attribute :last_name,                   String
  attribute :last_name_kana,              String
  attribute :phone_number,                String
  attribute :pickup_location,             Integer
  attribute :post_code,                   String
  attribute :room,                        String
  attribute :selected_seat,               String
  attribute :telephone,                   String
  attribute :tour_option_id,              Integer
  attribute :tour_order_id,               Integer
  attribute :tour_special_food_id,        Integer
  validates :age, numericality: { other_than: 0 }
  validates :birth_day, presence: true, if: -> { age.positive? }

  def age
    cal_age(birth_day)
  end

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/.freeze
end

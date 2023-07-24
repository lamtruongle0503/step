# frozen_string_literal: true

require 'tour/category'
require 'tour/company'
require 'tour/cancellation_policy'
class TourContracts::Base < ApplicationContract
  attribute :name,                        String
  attribute :code,                        String
  attribute :title,                       String
  attribute :start_date,                  Date
  attribute :end_date,                    Date
  attribute :type_locate,                 Integer
  attribute :stayed_nights,               Integer
  attribute :destination,                 String
  attribute :hostel_list,                 Integer
  attribute :meal_description,            String
  attribute :tax,                         Integer
  attribute :discount,                    Integer
  attribute :tour_guide,                  String
  attribute :is_show_guide,               Boolean

  attribute :point_bonus_rate,            Integer
  attribute :point_receive_rate,          Integer
  attribute :exp_point_bonus,             Integer
  attribute :exp_point_receive,           Integer

  attribute :tour_category_id,            Integer
  attribute :tour_company_id,             Integer
  attribute :company_staff_id,            Integer
  attribute :tour_cancellation_policy_id, Integer
  attribute :first_row_seat_price,        Integer
  attribute :two_rows_seat_price,         Integer
  attribute :regular_seat_price,          Integer
  attribute :info_travel_fee,             String
  attribute :transport_used,              String
  attribute :plan_implement,              String
  attribute :other_fee,                   String
  attribute :min_number_participant,      Integer

  # attribute :prefecture_ids, Array

  attribute :start_time,     Date
  attribute :end_time,       Date
  validates :name, presence: true
  # validates :prefecture_ids, existences: Prefecture.name, if: -> { prefecture_ids }

  validates :start_date, presence: true

  validates :end_date, presence:   true,
                       timeliness: {
                         on_or_after:         :start_date,
                         type:                :date,
                         on_or_after_message: I18n.t('.must_be_after_start_date'),
                       }
  validates :tour_category_id, presence: true, existence: Tour::Category.name
  validates :tour_company_id, presence: true, existence: Tour::Company.name
  validates :company_staff_id, presence: true, existence: CompanyStaff.name
  validates :tour_cancellation_policy_id, presence: true, existence: Tour::CancellationPolicy.name
  with_options length: { maximum: 15 }, presence: true do
    validates :min_number_participant
    validates :first_row_seat_price
    validates :two_rows_seat_price
    validates :regular_seat_price
    validates :exp_point_receive
  end
  validates :exp_point_bonus, length: { maximum: 15 }, if: -> { exp_point_bonus.present? }
end

# frozen_string_literal: true

class HotelContracts::OrderContracts::Base < ApplicationContract
  attribute :order_no, String
  attribute :user_id, Integer
  attribute :hotel_plan_id, Integer
  attribute :hotel_order_accompany_id, Integer
  attribute :check_in, Date
  attribute :check_out, Date
  attribute :coupon_id, Integer
  attribute :used_points, Integer
  attribute :number_night, Integer
  attribute :setting_children, Array
  attribute :cancellation_type, Integer
  attribute :cancellation_other_reason, String
  attribute :cancellation_free, Boolean
  attribute :payment_method, Integer
  attribute :people_statistic, String
  attribute :phone_reciprocal_time, String
  attribute :registrar_name, String
  attribute :registration_pattern, String
  attribute :time_estimate, String
  attribute :payment_method, Integer
  attribute :payment_status, Integer
  attribute :status, Integer
  attribute :date_cancel, Date

  validates :user_id, existence: User.name, if: -> { user_id }
  validates :hotel_plan_id, existence: Hotel::Plan.name
  validates :hotel_order_accompany_id, existence: Hotel::OrderAccompany.name
  validates :coupon_id, existence: Coupon.name, if: -> { coupon_id }
  validates :number_night, presence: true
  validates :check_in, presence:   true,
                       timeliness: {
                         on_or_before:        :check_out,
                         type:                :date,
                         on_or_after_message: I18n.t('hotels.orders.must_be_before_check_out'),
                       }
  validates :check_out, presence:   true,
                        timeliness: {
                          on_or_after:         :check_in,
                          type:                :date,
                          on_or_after_message: I18n.t('hotels.orders.must_be_after_check_in'),
                        }
  validates :cancellation_type, inclusion: { in: Hotel::Order.cancellation_types },
                                if:        -> { cancellation_type }
  validates :status, inclusion: { in: Hotel::Order.statuses }, if: -> { status }
  validates :payment_method, inclusion: { in: Hotel::Order.payment_methods }, if: -> { payment_method }
  validates :payment_status, inclusion: { in: Hotel::Order.payment_statuses }, if: -> { payment_status }
  validate :check_number_point, if: -> { user_id }
  validate :check_number_night, if: -> { number_night }

  def check_number_point
    user = User.find(user_id)
    point = user.point + user.point_bonus
    return if used_points <= point || used_points.zero?

    errors.add :used_points, I18n.t('hotels.orders.over_point')
  end

  def check_number_night
    return if (check_out - check_in).to_i == number_night

    errors.add :number_night, I18n.t('hotels.orders.number_night_no_right')
  end
end

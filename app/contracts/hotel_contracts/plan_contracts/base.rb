# frozen_string_literal: true

class HotelContracts::PlanContracts::Base < ApplicationContract
  attribute :name, String
  attribute :management_name, String
  attribute :type_plan, Integer
  attribute :type_meal, Array
  attribute :setting_show, Integer
  attribute :day_hidden, Integer
  attribute :payments, Array
  attribute :setting_payments, String
  attribute :start_stay_date, Date
  attribute :end_stay_date, Date
  attribute :setting_limit, Integer
  attribute :room_limit, Integer
  attribute :setting_number_night_stay, Integer
  attribute :from_night, Integer
  attribute :to_night, Integer
  attribute :setting_limit_room, Integer
  attribute :from_room, Integer
  attribute :to_room, Integer
  attribute :is_sale_off, Integer
  attribute :setting_sale_off, Object
  attribute :setting_check_in_out, Integer
  attribute :check_in, String
  attribute :check_out, String
  attribute :setting_children, Integer
  attribute :hotel_meal_id, Integer
  attribute :option_ids, Array
  attribute :hotel_cancellation_policy_id, Integer
  attribute :is_use_coupon, Boolean
  attribute :point_receive, Integer
  attribute :exp_point_receive, Integer
  attribute :point_bonus, Integer
  attribute :exp_point_bonus, Integer
  attribute :children_ids, Array
  attribute :rate_type, Integer
  attribute :credit_card_transaction_fee, Integer
  attribute :settlement_date, Integer
  attribute :settlement_time, String

  validates :name, presence: true
  validates :management_name, presence: true, length: { maximum: 10 }
  validates :type_plan, inclusion: { in: Hotel::Plan.type_plans }
  validates :setting_show, inclusion: { in: Hotel::Plan.setting_shows }
  validates :setting_limit, inclusion: { in: Hotel::Plan.setting_limits }
  validates :setting_number_night_stay, inclusion: { in: Hotel::Plan.setting_number_night_stays }
  validates :setting_limit_room, inclusion: { in: Hotel::Plan.setting_limit_rooms }
  validates :is_sale_off, inclusion: { in: Hotel::Plan.is_sale_offs }
  validates :setting_sale_off, presence: true, if: -> { is_sale_off == Hotel::Plan::SET }
  validates :setting_check_in_out, inclusion: { in: Hotel::Plan.setting_check_in_outs }
  validates :check_in, presence: true,
                       if:       -> { setting_check_in_out == Hotel::Plan::PLAN }
  validates :check_out, presence: true,
                        if:       -> { setting_check_in_out == Hotel::Plan::PLAN }
  validates :setting_children, inclusion: { in: Hotel::Plan.setting_children }
  validates :children_ids, existences: Hotel::ChildrenInfo.name,
                           if:         -> { setting_children == Hotel::Plan::POSSIBLE }
  validates :option_ids, existences: Hotel::Option.name
  validates :hotel_cancellation_policy_id, existence: Hotel::CancellationPolicy.name
  validates :point_bonus, inclusion: { in: 1..19 }, if: -> { point_bonus }
  validates :exp_point_bonus, inclusion: { in: 1..12 }, if: -> { exp_point_bonus }
  validates :start_stay_date, presence: true
  validates :end_stay_date, presence: true
  validate :exist_enum_type_meal, if: -> { type_meal }
  validates :payments, presence: true
  validate :exist_enum_method_payments
  validate :max_length_less_than_or_equal_fifteen_character, if: -> { is_sale_off == Hotel::Plan::SET }
  validates_datetime :start_stay_date, before:         :end_stay_date,
                                       before_message: I18n.t('.must_be_before_end_date')
  validates_datetime :end_stay_date, after:         :start_stay_date,
                                     after_message: I18n.t('.must_be_after_start_date')
  with_options length: { maximum: 15 }, numericality: { only_integer: true }, presence: true do
    validates :point_receive, if: -> { point_receive }
    validates :exp_point_receive, if: -> { exp_point_receive }
    validates :rate_type, if: -> { rate_type }
    validates :room_limit, if: -> { setting_limit == Hotel::Plan.setting_limits[:setting_number_room] }
    validates :settlement_date, if: -> { settlement_date }
    validates :day_hidden, if: -> { setting_show == Hotel::Plan.setting_shows[:setting_date] }

    validates :from_room, numericality: { greater_than_or_equal_to: 0,
                                          less_than_or_equal_to:    :to_room },
                          if:           lambda {
                                          setting_limit_room == Hotel::Plan::SETTING_ROOM
                                        }
    validates :to_room, numericality: { greater_than_or_equal_to: 0,
                                        great_than_or_equal_to:   :from_room },
                        if:           lambda {
                                        setting_limit_room == Hotel::Plan::SETTING_ROOM
                                      }
    validates :from_night, numericality: { greater_than_or_equal_to: 0,
                                           less_than_or_equal_to:    :to_night },
                           if:           -> { setting_number_night_stay_valid? }
    validates :to_night, numericality: { greater_than_or_equal_to: 0,
                                         great_than_or_equal_to:   :from_night },
                         if:           -> { setting_number_night_stay_valid? }
    validates :credit_card_transaction_fee, if: -> { credit_card_transaction_fee }
  end

  private

  def exist_enum_type_meal
    type = Hotel::Plan.meals.values
    type_meal.map do |i|
      next if type.include?(i)

      errors.add :type_meal, I18n.t('models.can_not_blank')
    end
  end

  def exist_enum_method_payments
    method_payments = Hotel::Plan.method_payments.values
    payments.map do |i|
      next if method_payments.include?(i)

      errors.add :payments, I18n.t('models.can_not_blank')
    end
  end

  def setting_number_night_stay_valid?
    setting_number_night_stay == Hotel::Plan::SETTING_NIGHT
  end

  def max_length_less_than_or_equal_fifteen_character
    setting_sale_off.each do |sale_off|
      next if sale_off['day'].to_s.length <= 15 && sale_off['percent'].to_s.length <= 15

      errors.add :setting_sale_off, I18n.t('hotels.plans.must_be_less_than_15_character')
    end
  end
end

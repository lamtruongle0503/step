# frozen_string_literal: true

class UserContracts::PointBonusContracts::Base < ApplicationContract
  attribute :title, String
  attribute :description, String
  attribute :start_date, Date
  attribute :end_date, Date
  attribute :received_point, Float
  attribute :user_ids, Array
  attribute :exp_start_date, Date
  attribute :exp_end_date, Date

  with_options presence: true do
    validates :title
    validates :description
    validates :start_date
    validates :end_date
    validates :received_point
    validates :exp_start_date
    validates :exp_end_date
    validates :user_ids, existences: User.name
  end

  validates :received_point, numericality: { greater_than_or_equal_to: 0 }
  validates_datetime :start_date, before: :end_date, before_message: I18n.t('.must_be_before_end_date')
  validates_datetime :end_date, after: :start_date, after_message: I18n.t('.must_be_after_start_date')
  validates_datetime :exp_start_date, before:         :exp_end_date,
                                      before_message: I18n.t('.must_be_before_end_date')
  validates_datetime :exp_end_date, after:         :exp_start_date,
                                    after_message: I18n.t('.must_be_after_start_date')
end

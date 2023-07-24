# frozen_string_literal: true

class CreditContracts::Create < ApplicationContract
  attribute :card_number, String
  attribute :exp_date,    String
  attribute :cvc_number,  String
  attribute :user_name,   String

  validates :card_number, presence: true, numericality: { only_integer: true }
  validates :exp_date, presence:   true,
                       timeliness: {
                         on_or_after:         -> { Date.current.end_of_month },
                         type:                :date,
                         on_or_after_message: I18n.t('.must_be_on_or_after_end_of_month'),
                       }
  validates :cvc_number, presence: true, numericality: { only_integer: true }
  validates :user_name, presence: true
end

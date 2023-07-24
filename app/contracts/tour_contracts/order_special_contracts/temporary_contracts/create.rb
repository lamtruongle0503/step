# frozen_string_literal: true

class TourContracts::OrderSpecialContracts::TemporaryContracts::Create < ApplicationContract
  attribute :phone_number, String

  PHONE_REGEX = /^(090|080|070|060)\d{8}$/.freeze

  validates :phone_number, format: { with: PHONE_REGEX, multiline: true },
                           numericality: true, if: lambda {
                                                     phone_number.present?
                                                   }
end

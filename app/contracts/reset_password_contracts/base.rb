# frozen_string_literal: true

class ResetPasswordContracts::Base < ApplicationContract
  attribute :phone_number, String
  attribute :password, String

  PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/.freeze

  validates :phone_number, presence: true, format: { with: PHONE_REGEX }, numericality: { only_integer: true }
end

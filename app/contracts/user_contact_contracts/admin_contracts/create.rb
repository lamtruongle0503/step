# frozen_string_literal: true

class UserContactContracts::AdminContracts::Create < UserContactContracts::AdminContracts::Base
  validates :phone_number, format: { with: PHONE_REGEX }, numericality: true, if: -> { phone_number.present? }
end

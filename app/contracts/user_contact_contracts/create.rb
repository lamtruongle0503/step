# frozen_string_literal: true

class UserContactContracts::Create < UserContactContracts::Base
  validates :phone_number, format:       { with: PHONE_REGEX },
                           numericality: true, if: -> { phone_number.present? }
end

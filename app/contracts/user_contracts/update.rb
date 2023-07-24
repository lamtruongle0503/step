# frozen_string_literal: true

class UserContracts::Update < UserContracts::Base
  attribute :record, User

  validates :phone_number, presence:     true,
                           format:       { with: PHONE_REGEX },
                           uniqueness:   { model: User },
                           numericality: true,
                           if:           -> { !same_phone_number }

  validates :status, inclusion: { in: User.statuses }, if: -> { status }

  validate :same_phone_number

  def same_phone_number
    record.phone_number == phone_number
  end
end

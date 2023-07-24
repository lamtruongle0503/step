# frozen_string_literal: true

class HolidayContracts::Update < HolidayContracts::Base
  attribute :record, Holiday

  validates :date, presence:   true,
                   uniqueness: { model: Holiday },
                   if:         -> { record.date != date }
end

# frozen_string_literal: true

class HolidayContracts::Create < HolidayContracts::Base
  validates :date, presence: true, uniqueness: { model: Holiday }
end

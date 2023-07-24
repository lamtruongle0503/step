# frozen_string_literal: true

class HolidayContracts::Base < ApplicationContract
  attribute :holiday_name, String
  attribute :date, Date

  validates :holiday_name, presence: true
end

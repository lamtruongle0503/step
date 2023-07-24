# frozen_string_literal: true

class Api::FortuneOperations::Index < ApplicationOperation
  def call
    today    = Fortune.by_date(Date.today.strftime('%Y%m%d'))
    tomorrow = Fortune.by_date(Date.tomorrow.strftime('%Y%m%d'))

    { today: today, tomorrow: tomorrow }
  end
end

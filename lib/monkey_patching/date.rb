# frozen_string_literal: true

class Date
  def as_json(_options = {})
    strftime('%Y/%m/%d')
  end
end

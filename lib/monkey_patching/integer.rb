# frozen_string_literal: true

class Integer
  def to_bool
    !zero?
  end
end

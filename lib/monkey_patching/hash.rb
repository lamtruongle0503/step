# frozen_string_literal: true

class Hash
  def included_in?(another)
    merge(another) == self
  end
end

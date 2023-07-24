# frozen_string_literal: true

class Array
  def uniq?
    uniq.size == size
  end
end

# frozen_string_literal: true

class Float
  def discount_of(number)
    self - (self.to_f * number.to_f / 100.0) # rubocop:disable Style/RedundantSelf
  end
end

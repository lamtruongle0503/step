# frozen_string_literal: true

class String
  def sjis_encode
    encode(Encoding::SJIS, invalid: :replace, undef: :replace)
  end
  
  def is_integer?
    self.to_i.to_s == self
  end
end

# frozen_string_literal: true

class String
  def to_bool
    to_s
    return false if self == 'false' || self == '0'
    return true if self == 'true' || self == '1'

    raise ArgumentError, "invalid value for Boolean: \"#{self}\""
  end

  def to_const
    camelize.constantize
  end

  def parse_date
    to_date
  rescue StandardError
    self
  end

  def remove_html_tags
    ActionView::Base.full_sanitizer.sanitize(self)
  rescue StandardError
    self
  end
end

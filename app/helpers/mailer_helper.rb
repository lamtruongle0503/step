# frozen_string_literal: true

module MailerHelper
  def expect_delivery_time(start_time, end_time)
    return unless start_time && end_time

    "#{I18n.l(start_time, format: :only_time)}～#{I18n.l(end_time, format: :only_time)}"
  end

  def valid_delivery?(current)
    ->(delivery_name) { delivery_name.include?(current) }
  end
end

# frozen_string_literal: true

class EcommerceContracts::DeliveryTimeSettingContracts::Base < ApplicationContract
  attribute :start_time, Time
  attribute :end_time, Time

  # validates_time :end_time, timeliness: {
  #   after: :start_time,
  #   after_message: I18n.t('.must_be_after_start_time'),
  # }
end

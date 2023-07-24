# frozen_string_literal: true

module EcommerceContracts::DeliveryTimeSettingContracts
  class Create < Base
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates_datetime :end_time,
                       after:         :start_time,
                       after_message: I18n.t('.must_be_after_start_time')
  end
end

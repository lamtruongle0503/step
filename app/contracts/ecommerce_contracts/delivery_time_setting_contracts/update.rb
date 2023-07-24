# frozen_string_literal: true

module EcommerceContracts::DeliveryTimeSettingContracts
  class Update < Base
    attribute :id,         Integer
    attribute :_destroy,   String
    attribute :product_id, Integer

    validates :start_time, :end_time, presence: true, if: -> { id.blank? }
    validates_datetime :end_time,
                       after:         :start_time,
                       after_message: I18n.t('.must_be_after_start_time'), if: -> { id.blank? }
    validate :start_time_and_time_must_unique, if: -> { id.blank? }

    def start_time_and_time_must_unique
      return unless DeliveryTimeSetting.exists?(start_time: start_time, end_time: end_time,
                                                product_id: product_id)

      errors.add(:start_time, I18n.t('models.exists'))
    end
  end
end

# frozen_string_literal: true

module EcommerceContracts::DeliverySettingContracts
  class Update < Base
    attribute :id, Integer

    validates :price, presence: true, numericality: true, if: -> { id.blank? }
  end
end

# frozen_string_literal: true

module EcommerceContracts::DeliverySettingContracts
  class Create < Base
    validates :price, presence: true, numericality: true
  end
end

# frozen_string_literal: true

class EcommerceContracts::DeliverySettingContracts::Base < ApplicationContract
  attribute :vendor, String
  attribute :memo, String
  attribute :other, String
  attribute :price, Float
end

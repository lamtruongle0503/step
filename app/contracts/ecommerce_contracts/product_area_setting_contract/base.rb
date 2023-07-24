# frozen_string_literal: true

class EcommerceContracts::ProductAreaSettingContract::Base < ApplicationContract
  attribute :area_setting_id, Integer
  attribute :price,           Float
end

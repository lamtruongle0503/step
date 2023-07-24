# frozen_string_literal: true

module EcommerceContracts::ProductAreaSettingContract
  class Create < Base
    validates :area_setting_id, existence: AreaSetting.name
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  end
end

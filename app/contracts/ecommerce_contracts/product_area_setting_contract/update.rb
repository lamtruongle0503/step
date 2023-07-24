# frozen_string_literal: true

module EcommerceContracts::ProductAreaSettingContract
  class Update < Base
    attribute :id,         Integer
    attribute :product_id, Integer

    validates :area_setting_id, existence: AreaSetting.name, if: -> { id.blank? }
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }, if: -> { id.blank? }
    validate :product_area_setting_must_unique, if: -> { id.blank? }

    def product_area_setting_must_unique
      return unless ProductAreaSetting.exists?(area_setting_id: area_setting_id,
                                               product_id:      product_id)

      errors.add(:area_setting_id, I18n.t('models.exists'))
    end
  end
end

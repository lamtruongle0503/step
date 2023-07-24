# frozen_string_literal: true

class EcommerceContracts::ProductContracts::Update < EcommerceContracts::ProductContracts::Base
  attribute :product, Product

  validate :code_valid

  def code_valid
    return unless code

    errors.add(:code, I18n.t('.already_exists')) if code != product.code
  end

  def product_sizes
    product_sizes_attributes.each do |obj|
      EcommerceContracts::ProductSizeContracts::Update.new(obj).valid!
    end
  end

  def delivery_time_settings
    delivery_time_settings_attributes.each do |obj|
      EcommerceContracts::DeliveryTimeSettingContracts::Update.new(obj.merge(product_id: product.id)).valid!
    end
  end

  def product_area_settings
    product_area_settings_attributes.each do |obj|
      EcommerceContracts::ProductAreaSettingContract::Update.new(obj.merge(product_id: product.id)).valid!
    end
  end
end

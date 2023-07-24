# frozen_string_literal: true

class EcommerceContracts::ProductContracts::Create < EcommerceContracts::ProductContracts::Base
  validates :code, presence: true, uniqueness: { model: Product }

  def product_sizes
    product_sizes_attributes.each { |obj| EcommerceContracts::ProductSizeContracts::Create.new(obj).valid! }
  end

  def delivery_time_settings
    delivery_time_settings_attributes.each do |obj|
      EcommerceContracts::DeliveryTimeSettingContracts::Create.new(obj).valid!
    end
  end

  def product_area_settings
    product_area_settings_attributes.each do |obj|
      EcommerceContracts::ProductAreaSettingContract::Create.new(obj).valid!
    end
  end
end

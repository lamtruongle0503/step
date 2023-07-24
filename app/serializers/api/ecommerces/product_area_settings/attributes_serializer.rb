# frozen_string_literal: true

class Api::Ecommerces::ProductAreaSettings::AttributesSerializer < ApplicationSerializer
  attributes :id, :price, :area_setting

  def area_setting
    Api::Ecommerces::AreaSettings::AttributesSerializer.new(object.area_setting)
  end
end

# frozen_string_literal: true

class Admin::Ecommerces::ProductAreaSettings::AttributesSerializer < ApplicationSerializer
  attributes :id, :price, :area

  def area
    Admin::AreaSettings::AttributesSerializer.new(object.area_setting)
  end
end

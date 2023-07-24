# frozen_string_literal: true

class Admin::EcommerceOperations::DeliveryAreaOperations::Index < ApplicationOperation
  def call
    AreaSetting.all
  end
end

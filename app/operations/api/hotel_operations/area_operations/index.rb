# frozen_string_literal: true

class Api::HotelOperations::AreaOperations::Index < ApplicationOperation
  def call
    AreaSetting.all
  end
end

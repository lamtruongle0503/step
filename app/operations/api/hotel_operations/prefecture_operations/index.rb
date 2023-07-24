# frozen_string_literal: true

class Api::HotelOperations::PrefectureOperations::Index < ApplicationOperation
  def call
    Prefecture.find_by_area_setting(params[:area_setting_id])
  end
end

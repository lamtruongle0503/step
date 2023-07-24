# frozen_string_literal: true

class Admin::HolidayOperations::Destroy < ApplicationOperation
  def call
    authorize nil, HolidayPolicy

    holiday = Holiday.find(params[:id])
    holiday.destroy!
  end
end

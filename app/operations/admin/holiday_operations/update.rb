# frozen_string_literal: true

class Admin::HolidayOperations::Update < ApplicationOperation
  def call
    authorize nil, HolidayPolicy

    holiday = Holiday.find(params[:id])
    ActiveRecord::Base.transaction do
      HolidayContracts::Update.new(holiday_params.merge(record: holiday)).valid!
      holiday.update!(holiday_params)
    end
  end

  private

  def holiday_params
    params.permit(:holiday_name, :date)
  end
end

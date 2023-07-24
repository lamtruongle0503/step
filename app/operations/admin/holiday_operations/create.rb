# frozen_string_literal: true

class Admin::HolidayOperations::Create < ApplicationOperation
  def call
    authorize nil, HolidayPolicy

    ActiveRecord::Base.transaction do
      HolidayContracts::Create.new(holiday_params).valid!
      Holiday.create!(holiday_params)
    end
  end

  private

  def holiday_params
    params.permit(:holiday_name, :date)
  end
end

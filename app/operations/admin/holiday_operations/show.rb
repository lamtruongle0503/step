# frozen_string_literal: true

class Admin::HolidayOperations::Show < ApplicationOperation
  def call
    authorize nil, HolidayPolicy

    Holiday.find(params[:id])
  end
end

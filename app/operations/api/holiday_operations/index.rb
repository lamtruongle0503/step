# frozen_string_literal: true

class Api::HolidayOperations::Index < ApplicationOperation
  def call
    @q = Holiday.ransack(params[:q])
    @q.result.newest.page(params[:page])
  end
end

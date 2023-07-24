# frozen_string_literal: true

class Admin::HolidayOperations::Index < ApplicationOperation
  def call
    authorize nil, HolidayPolicy

    @q = Holiday.sort_by_date(params[:sort_date_asc]).ransack(params[:q])
    @q.result.newest.page(params[:page])
  end
end

# frozen_string_literal: true

class Admin::TourOperations::MetaOperations::Index < ApplicationOperation
  def call
    @q = Tour.includes(:prefectures).available_by_end_date.ransack(params[:q])
    @q.result(distinct: true)
  end
end

# frozen_string_literal: true

class Admin::LifeSupportOperations::Index < ApplicationOperation
  def call
    authorize nil, LifeSupportPolicy

    @q = LifeSupport.ransack(params[:q])
    @q.result.includes(:prefectures, :assets).newest.page(params[:page])
  end
end

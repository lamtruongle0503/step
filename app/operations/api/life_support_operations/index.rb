# frozen_string_literal: true

class Api::LifeSupportOperations::Index < ApplicationOperation
  def call
    @q = LifeSupport.ransack(params[:q])
    @q.result.available.includes(:assets).newest.page(params[:page])
  end
end

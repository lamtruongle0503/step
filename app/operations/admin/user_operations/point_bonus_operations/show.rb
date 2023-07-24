# frozen_string_literal: true

class Admin::UserOperations::PointBonusOperations::Show < ApplicationOperation
  def call
    @point_bonuse = PointUsage.find(params[:id])
  end
end

# frozen_string_literal: true

class Admin::UserOperations::PointBonusOperations::Index < ApplicationOperation
  def call
    @q = PointUsage.ransack(params[:q])
    @q.result.includes(:user).where(module_type: Admin.name)
      .where.not(received_point: 0).newest.page(params[:page])
  end
end

# frozen_string_literal: true

class Admin::UserOperations::HistoryOperations::PointOperations::Index < ApplicationOperation
  attr_reader :user

  def initialize(actor, params)
    super
    @user = User.find(params[:id])
  end

  def call
    histories = user.point_usages
                    .where(module_type: [Order.name, Hotel::Order.name, Tour::Order.name, Admin.name])
                    .includes(module: :order).newest

    user_point           = user.point + user.point_bonus
    bonus_point_received = user.point_bonus
    { histories: histories, user_point: user_point, bonus_point: bonus_point_received }
  end
end

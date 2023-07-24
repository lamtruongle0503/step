# frozen_string_literal: true

class Api::UserOperations::PointOperations::History < ApplicationOperation
  def call
    histories = actor.point_usages
                     .where(module_type: [Order.name, Hotel::Order.name, Tour::Order.name, Admin.name])
                     .includes(module: :order).newest

    user_point           = actor.point + actor.point_bonus
    bonus_point_received = actor.point_bonus

    { histories: histories, user_point: user_point, bonus_point: bonus_point_received }
  end
end

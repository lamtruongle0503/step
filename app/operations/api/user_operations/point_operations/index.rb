# frozen_string_literal: true

class Api::UserOperations::PointOperations::Index < ApplicationOperation
  def call
    { point: actor.point.to_i + actor.point_bonus.to_i }
  end
end

# frozen_string_literal: true

class Api::V1::Users::PointBonusesController < ApiV1Controller
  before_action :authentication!

  def check_receive
    point_bonus = Api::UserOperations::PointBonuseOperations::CheckReceive.new(actor, params).call
    render json: point_bonus, serializer: Api::Users::PointBonuses::CheckReceiveSerializer,
           root: 'point_bonus'
  end
end

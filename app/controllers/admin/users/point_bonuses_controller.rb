# frozen_string_literal: true

class Admin::Users::PointBonusesController < ApiV1Controller
  before_action :authentication!

  def create
    Admin::UserOperations::PointBonusOperations::Create.new(actor, params).call
    render json: {}
  end

  def index
    point_bonus = Admin::UserOperations::PointBonusOperations::Index.new(actor, params).call
    render json: point_bonus, each_serializer: Admin::Users::PointBonuseSerializer::IndexSerializer,
           meta: pagination_dict(point_bonus), root: 'point_bonus', adapter: :json
  end

  def show
    point_bonuse = Admin::UserOperations::PointBonusOperations::Show.new(actor, params).call
    render json: point_bonuse, serializer: Admin::Users::PointBonuseSerializer::ShowSerializer
  end
end

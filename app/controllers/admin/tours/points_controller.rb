# frozen_string_literal: true

class Admin::Tours::PointsController < ApiV1Controller
  before_action :authentication!

  def index
    users = Admin::TourOperations::PointOperations::Index.new(actor, params).call
    render json:            users,
           each_serializer: Admin::Tours::Points::AttributesSerializer,
           #  meta: pagination_dict(users),
           root:            'data',
           adapter:         :json
  end

  def create
    Admin::TourOperations::PointOperations::Create.new(actor, params).call
    render json: {}
  end
end

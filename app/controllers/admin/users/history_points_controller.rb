# frozen_string_literal: true

class Admin::Users::HistoryPointsController < ApiV1Controller
  before_action :authentication!

  def index
    render json: Admin::UserOperations::HistoryOperations::PointOperations::Index.new(actor, params).call,
           serializer: Admin::Users::Histories::Points::AttributesSerializer, root: 'users'
  end
end

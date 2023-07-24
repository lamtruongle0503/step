# frozen_string_literal: true

class Api::V1::Users::PointsController < ApiV1Controller
  before_action :authentication!, only: %i[index history]

  def index
    render json: Api::UserOperations::PointOperations::Index.new(actor, params).call,
           serializer: Api::Users::Points::IndexSerializer, root: 'users'
  end

  def history
    render json: Api::UserOperations::PointOperations::History.new(actor, params).call,
           serializer: Api::Users::Points::HistorySerializer, root: 'users'
  end

  def sync
    Api::UserOperations::PointOperations::Sync.new(nil, params).call
    render json: {}
  end
end

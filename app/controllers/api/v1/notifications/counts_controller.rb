# frozen_string_literal: true

class Api::V1::Notifications::CountsController < ApiV1Controller
  before_action :authentication!

  def index
    render json: Api::NotificationOperations::CountOperations::Index.new(actor, params).call,
           serializer: Api::Notifications::Counts::IndexSerializer, root: 'notificaitons'
  end
end

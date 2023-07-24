# frozen_string_literal: true

class Api::V1::Notifications::UnreadsController < ApiV1Controller
  before_action :authentication!

  def update
    render json: Api::NotificationOperations::UnreadOperations::Update.new(actor, params).call,
           serializer: Api::Notifications::Unreads::UpdateSerializer, root: 'notificaitons'
  end
end

# frozen_string_literal: true

class Api::V1::NotificationsController < ApiV1Controller
  before_action :authentication!

  def index
    notifications = Api::NotificationOperations::Index.new(actor, params).call
    render json: notifications, each_serializer: Api::Notifications::IndexSerializer,
           meta: pagination_dict(notifications), root: 'data', adapter: :json
  end

  def show
    render json: Api::NotificationOperations::Show.new(actor, params).call,
           serializer: Api::Notifications::ShowSerializer, root: 'notifications'
  end
end

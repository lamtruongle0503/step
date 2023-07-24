# frozen_string_literal: true

class Admin::NotificationsController < ApiV1Controller
  before_action :authentication!

  def create
    render json: Admin::NotificationOperations::Create.new(actor, params).call,
           serializer: Admin::Notifications::CreateSerializer, root: 'notifications'
  end

  def index
    notifications = Admin::NotificationOperations::Index.new(actor, params).call
    render json: notifications,
           each_serializer: Admin::Notifications::IndexSerializer,
           meta: pagination_dict(notifications), root: 'data', adapter: :json
  end

  def show
    render json: Admin::NotificationOperations::Show.new(actor, params).call,
           serializer: Admin::Notifications::ShowSerializer, root: 'notifications'
  end

  def update
    render json: Admin::NotificationOperations::Update.new(actor, params).call,
           serializer: Admin::Notifications::UpdateSerializer, root: 'notifications'
  end

  def destroy
    render json: Admin::NotificationOperations::Destroy.new(actor, params).call,
           serializer: Admin::Notifications::DestroySerializer, root: 'notifications'
  end
end

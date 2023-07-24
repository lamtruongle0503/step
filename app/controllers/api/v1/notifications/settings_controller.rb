# frozen_string_literal: true

class Api::V1::Notifications::SettingsController < ApiV1Controller
  before_action :authentication!

  def create
    render json: Api::NotificationOperations::SettingOperations::Create.new(actor, params).call,
           serializer: Api::Notifications::Settings::CreateSerializer, root: 'notificaitons'
  end
end

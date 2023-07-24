# frozen_string_literal: true

class Api::V1::AdminSettingsController < ApiV1Controller
  def index
    render json: Api::AdminSettingOperations::Index.new(nil, params).call,
           serializer: Api::AdminSettings::IndexSerializer, root: 'admin_settings'
  end
end

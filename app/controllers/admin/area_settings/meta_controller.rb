# frozen_string_literal: true

class Admin::AreaSettings::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    area_settings = Admin::AreaSettingOperations::MetaOperations::Index.new(actor, params).call
    render json: area_settings, each_serializer: Admin::AreaSettings::Meta::IndexSerializer
  end
end

# frozen_string_literal: true

class Api::AdminSettingOperations::Index < ApplicationOperation
  def call
    AdminSetting.find_by!(key: params[:key])
  end
end

# frozen_string_literal: true

class Admin::AreaSettingOperations::MetaOperations::Index < ApplicationOperation
  def call
    AreaSetting.all
  end
end

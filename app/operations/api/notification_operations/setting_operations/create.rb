# frozen_string_literal: true

class Api::NotificationOperations::SettingOperations::Create < ApplicationOperation
  def call
    is_receive = actor.is_receive
    actor.update!(is_receive: !is_receive)
  end
end

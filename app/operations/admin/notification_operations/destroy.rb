# frozen_string_literal: true

class Admin::NotificationOperations::Destroy < ApplicationOperation
  def call
    authorize Notification

    Notification.find(params[:id])&.destroy!
  end
end

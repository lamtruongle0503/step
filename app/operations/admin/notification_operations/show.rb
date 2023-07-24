# frozen_string_literal: true

class Admin::NotificationOperations::Show < ApplicationOperation
  def call
    authorize Notification

    Notification.find(params[:id])
  end
end

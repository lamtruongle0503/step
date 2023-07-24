# frozen_string_literal: true

class Admin::NotificationOperations::Index < ApplicationOperation
  def call
    authorize Notification

    Notification.where(module: nil).order(created_at: :desc).page(params[:page])
  end
end

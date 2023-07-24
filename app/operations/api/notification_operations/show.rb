# frozen_string_literal: true

class Api::NotificationOperations::Show < ApplicationOperation
  def call
    Notification.find(params[:id])
  end
end

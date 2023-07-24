# frozen_string_literal: true

class Api::NotificationOperations::UnreadOperations::Update < ApplicationOperation
  def call
    unread_notifications = actor.users_notifications.where(is_read: false)
    unread_notifications.update_all(is_read: true)
  end
end

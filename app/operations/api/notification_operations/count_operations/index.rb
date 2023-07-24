# frozen_string_literal: true

class Api::NotificationOperations::CountOperations::Index < ApplicationOperation
  def call
    unread_notifications = actor.users_notifications.where(is_read: false)
    { unread_number: unread_notifications.size }
  end
end

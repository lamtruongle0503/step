# frozen_string_literal: true

class Admin::NotificationOperations::Update < ApplicationOperation
  attr_reader :notification, :users

  def initialize(actor, params)
    super
    @notification = Notification.find(params[:id])
  end

  def call
    authorize Notification

    NotificationContracts::Update.new(notification_params
                                     .merge(prefecture_ids: params[:prefecture_ids])).valid!
    ActiveRecord::Base.transaction do
      update_notification!
      update_notifications_prefectures(notification) if params[:prefecture_ids]
      update_notifications_users(notification)
      upload_image(notification)
    end
    push_notification(notification.reload) if params[:is_resend]
  end

  private

  def update_notification!
    notification.update!(notification_params)
  end

  def notification_params
    params.permit(:title, :description, :gender, :is_gender, :is_prefecture, :is_resend, month_birthday: [])
  end

  def update_notifications_prefectures(notification)
    prefecture_ids = notification.prefectures.pluck(:id)
    add_prefecture_ids = params[:prefecture_ids] - prefecture_ids
    remove_prefecture_ids = prefecture_ids - params[:prefecture_ids]
    notification.notifications_prefectures.by_prefecture_ids(remove_prefecture_ids)
                .update_all(deleted_at: Time.now)
    NotificationsPrefecture.import! build_notifications_prefectures(notification, add_prefecture_ids)
  end

  def update_notifications_users(notification)
    notification.users_notifications.update_all(deleted_at: Time.now)
    UsersNotification.import! build_notifications_users(notification)
  end

  def build_notifications_prefectures(notification, add_ids)
    add_ids.map { |id| { notification_id: notification.id, prefecture_id: id } }
  end

  def upload_image(notification)
    return unless params[:file]

    upload_file(notification, params[:file][:url], params[:file][:type], params[:file][:file_type])
  end

  def push_notification(notification)
    options = {
      module_type: Notification.name,
      module_id:   notification.id,
    }
    # (title, data, body, user_ids)
    FcmNotificationService.new(
      notification.title,
      options,
      notification.description,
      users.pluck(:id).uniq,
      notification.asset&.url,
    ).send_notification
  end
end

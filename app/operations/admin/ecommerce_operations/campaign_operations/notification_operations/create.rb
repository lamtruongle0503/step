# frozen_string_literal: true

class Admin::EcommerceOperations::CampaignOperations::NotificationOperations::Create < ApplicationOperation
  attr_reader :campaign, :notification, :users

  def initialize(actor, params)
    super
    @campaign = Campaign.find(params[:campaign_id])
  end

  def call
    EcommerceContracts::CampaignContracts::NotificationContracts::Create.new(notification_params).valid!
    ActiveRecord::Base.transaction do
      @notification = create_notification!
      create_notifications_prefectures(notification) if params[:prefecture_ids]
      create_notifications_users(notification)
      upload_image(notification)
    end
    push_notification(notification, @campaign.id)
    notification
  end

  private

  def create_notification!
    Notification.create!(notification_params.merge(module: campaign))
  end

  def notification_params
    params.permit(:title, :description, :gender, :is_gender, :is_prefecture, prefecture_ids: [])
  end

  def create_notifications_prefectures(notification)
    NotificationsPrefecture.import! build_notifications_prefectures(notification)
  end

  def create_notifications_users(notification)
    UsersNotification.import! build_notifications_users(notification)
  end

  def build_notifications_prefectures(notification)
    params[:prefecture_ids].map { |id| { notification_id: notification.id, prefecture_id: id } }
  end

  def upload_image(notification)
    return unless params[:file]

    upload_file(notification, params[:file][:url], params[:file][:type], params[:file][:file_type])
  end

  def push_notification(notification, campaign_id)
    options = {
      module_type:     notification.module_type,
      module_id:       notification.module_id,
      type:            'Campaign',
      campaign_id:     campaign_id,
      notification_id: notification.id,
    }
    FcmNotificationService.new(
      notification.title,
      options,
      notification.description,
      users.pluck(:id).uniq,
      notification.asset&.url,
    ).send_notification
  end
end

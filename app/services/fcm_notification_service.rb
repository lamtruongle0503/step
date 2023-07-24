# frozen_string_literal: true

require 'fcm'

class FcmNotificationService
  def initialize(title, data, body, user_ids, image)
    @fcm = FCM.new(ENV['FCM_KEY'] || Rails.application.credentials.fcm_key)
    @user_ids = user_ids
    @data = data
    @body = body
    @title = title
    @image = image.to_s
  end

  def list_device_token
    Device.joins(:user)
          .where(user_id: @user_ids)
          .map(&:device_token)
          .uniq
  end

  def send_notification
    options = {
      data:         @data,
      notification: {
        title: @title,
        body:  @body.gsub('</p>', "\r\n").remove_html_tags,
        sound: 'default',
        image: @image,
      },
      android:      {
        channel_id: ENV['CHANNEL_ID'],
        priority:   'high',
      },
      apns:         {
        payload:     {
          aps: {
            mutable_content:   1,
            content_available: true,
          },
        },
        fcm_options: {
          image: @image,
        },
      },
    }
    registration_ids = list_device_token
    return if registration_ids.blank?

    registration_ids.each_slice(500) { |ids| @fcm.send(ids, options) }
  end
end

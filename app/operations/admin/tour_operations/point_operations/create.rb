# frozen_string_literal: true

class Admin::TourOperations::PointOperations::Create < ApplicationOperation
  def call
    user_ids = params[:user_ids]
    if !params[:is_send_point] || params_point[:received_point].blank?
      push_notification_without_point(user_ids)
    else
      create_point_bonus(user_ids)
    end
  end

  private

  def params_point
    params.permit(:title, :description, :start_date, :end_date, :received_point, :exp_start_date,
                  :exp_end_date)
  end

  def push_notification_without_point(user_ids)
    notification = Notification.create!(title: params[:title], description: params[:description])
    users_notifications = []
    user_ids.each do |id|
      users_notifications.push(user_id: id, notification_id: notification.id)
    end

    UsersNotification.import!(users_notifications)

    options = {
      module_type: Notification.name,
      module_id:   notification.id,
    }

    FcmNotificationService.new(
      notification.title,
      options,
      notification.description,
      user_ids.uniq,
      nil,
    ).send_notification
  end

  def create_point_bonus(user_ids) # rubocop:disable Metrics/MethodLength
    UserContracts::PointBonusContracts::Create.new(params_point.merge(
                                                     user_ids: user_ids,
                                                   )).valid!
    obj_params = {
      module_type:    Admin.name,
      module_id:      actor.id,
      title:          params[:title],
      description:    params[:description],
      start_date:     params[:start_date],
      end_date:       params[:end_date],
      type_point:     PointUsage::BONUS,
      received_point: params[:received_point],
      exp_start_date: params[:exp_start_date],
      exp_end_date:   params[:exp_end_date],
      status:         PointUsage::PENDING,
    }
    options_data = []
    user_ids.each do |user_id|
      options_data.push(obj_params.merge(user_id: user_id))
    end
    ActiveRecord::Base.transaction do
      @point_bonus = PointUsage.import!(options_data)
    end

    option_notification = []
    @point_bonus.ids.each do |id|
      point_usage = PointUsage.find_by!(id: id)
      options = {
        title:       point_usage.title,
        description: point_usage.description,
        module_type: PointUsage.name,
        module_id:   point_usage.id,
      }
      option_notification.push(options)
    end
    create_notification(option_notification)
  end

  def create_notification(options)
    ActiveRecord::Base.transaction do
      @notifications = Notification.import!(options)
    end

    option_user_notification = []
    Notification.includes(:point_usage).where(id: @notifications.ids).each do |notification|
      user_id = notification.point_usage.user_id
      option_user_notification.push(user_id: user_id, notification_id: notification.id)
      push_notification(notification, notification.point_usage.user_id)
    end
    ActiveRecord::Base.transaction do
      UsersNotification.import!(option_user_notification)
    end
  end

  def push_notification(notification, user_id)
    options = {
      module_type: Notification.name,
      module_id:   notification.id,
      type:        'point_bonus',
    }
    # (title, data, body, user_ids)
    FcmNotificationService.new(
      notification.title,
      options,
      notification.description,
      user_id,
      nil,
    ).send_notification
  end
end

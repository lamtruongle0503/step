# frozen_string_literal: true

require 'tour/order'

class Api::UserOperations::PointOperations::Sync < ApplicationOperation
  def call
    ActiveRecord::Base.transaction do
      update_received_points!
      remove_point_expired!
    end
  end

  private

  def update_received_points!
    point_usages = PointUsage.where(
      module_type: [Order.name, Tour::Order.name, Hotel::Order.name],
      status:      PointUsage::PENDING,
      start_date:  Date.today,
      is_received: false,
    )
    return if point_usages.blank?

    point_usages.includes(:user).each do |point_usage|
      end_date = case point_usage.module_type
                 when Order.name
                   end_date_point(point_usage)
                 when Tour::Order.name
                   end_date_point_tour(point_usage)
                 when Hotel::Order.name
                   end_date_point_hotel(point_usage)
                 end

      point_usage.update!(
        status:      PointUsage::ACCEPT,
        end_date:    end_date,
        is_received: true,
      )
      if point_usage.type_point == PointUsage::NORMAL
        point_usage.user.increment!(:point, point_usage.received_point)
      else
        point_usage.user.increment!(:point_bonus, point_usage.received_point)
      end
    end
  end

  def end_date_point(point_usage)
    if point_usage.type_point == PointUsage::NORMAL
      Date.today + 1.years
    else
      Date.today + 6.months
    end
  end

  def end_date_point_tour(point_usage)
    month_point_normal = point_usage.module.tour.exp_point_receive.months
    month_point_bonus  = point_usage.module.tour.exp_point_bonus&.months || 6.months
    if point_usage.type_point == PointUsage::NORMAL
      Date.today + month_point_normal
    else
      Date.today + month_point_bonus
    end
  end

  def end_date_point_hotel(point_usage)
    month_point_normal = point_usage.module.hotel_plan.exp_point_receive.months
    month_point_bonus  = point_usage.module.hotel_plan.exp_point_bonus&.months || 6.months
    if point_usage.type_point == PointUsage::NORMAL
      Date.today + month_point_normal
    else
      Date.today + month_point_bonus
    end
  end

  def remove_point_expired!
    user_ids = PointUsage.where(end_date: Date.today).pluck(:user_id)
    User.where(id: user_ids).each do |user|
      decrement_point_expired(user, PointUsage::NORMAL)
      decrement_point_expired(user, PointUsage::BONUS)
    end
  end

  def decrement_point_expired(user, type_point)
    total_point_received = user.point_usages.where(
      end_date:    Date.today,
      used_point:  nil,
      is_received: true,
      type_point:  type_point,
    ).sum(:received_point)

    total_point_used = user.point_usages.where(
      end_date:       Date.today,
      received_point: nil,
      type_point:     type_point,
    ).sum(:used_point)

    return if total_point_used >= total_point_received

    user.point_usages.create!(
      module_type: Admin.name,
      module_id:   1,
      used_point:  total_point_received - total_point_used,
      start_date:  Date.today,
      end_date:    Date.today,
      type_point:  type_point,
    )

    if type_point == PointUsage::BONUS
      user.decrement!(:point_bonus, total_point_received - total_point_used)
    else
      user.decrement!(:point, total_point_received - total_point_used)
    end
  end
end

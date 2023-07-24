# frozen_string_literal: true

class Api::UserOperations::PointBonuseOperations::CheckReceive < ApplicationOperation
  attr_reader :point_bonuses, :notification

  def initialize(actor, params)
    super
    @notification = Notification.find(params[:point_bonuse_id])
    @point_bonuses = notification.point_usage
  end

  def call # rubocop:disable Metrics/PerceivedComplexity
    if !point_bonuses || point_bonuses.is_received? || !point_bonuses.start_date || !point_bonuses.end_date
      return { is_expried: true }
    end

    ActiveRecord::Base.transaction do
      point_bonuses.lock!
      if Time.current.between?(point_bonuses.start_date,
                               point_bonuses.end_date) || Time.current < point_bonuses.start_date
        return { is_expried: true } if notification.point_usage.is_received?

        point_bonuses.update!(is_received: true, status: PointUsage::ACCEPT, received_date: Time.zone.now)
        actor.increment!(:point_bonus, point_bonuses.received_point)
        { is_expried: false }
      else
        point_bonuses.destroy!
        { is_expried: true }
      end
    end
  end
end

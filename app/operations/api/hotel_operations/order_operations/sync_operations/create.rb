# frozen_string_literal: true

class Api::HotelOperations::OrderOperations::SyncOperations::Create < ApplicationOperation
  def call
    @point_usages = PointUsage.includes(:module, :user, hotel_order: :user).point_usage_hotel
    @point_usages.map do |obj|
      next unless (Time.current.to_date - obj.created_at.to_date).to_i >= 10

      ActiveRecord::Base.transaction do
        obj.update!(module: obj.hotel_order, is_received: true)
        obj.hotel_order.user.increment!(:point, obj.received_point)
      end
    end
  end
end

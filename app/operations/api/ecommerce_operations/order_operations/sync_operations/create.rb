# frozen_string_literal: true

class Api::EcommerceOperations::OrderOperations::SyncOperations::Create < ApplicationOperation
  attr_reader :point_usages

  def initialize(actor, params)
    super
    @point_usages = PointUsage.where(
      module_type: Order.name,
      status:      PointUsage::PENDING,
    ).ransack(start_date_eq: DateTime.current).result
  end

  def call
    ActiveRecord::Base.transaction do
      return unless point_usages.present?

      point_usages.includes(:user).each do |point_usage|
        end_date = if point_usage.type_point == PointUsage::NORMAL
                     DateTime.current + 1.years
                   else
                     DateTime.current + 6.months
                   end
        point_usage.update!(
          status:   PointUsage::ACCEPT,
          end_date: end_date,
        )
        if point_usage.type_point == PointUsage::NORMAL
          point_usage.user.increment!(:point, point_usage.received_point)
        else
          point_usage.user.increment!(:point_bonus, point_usage.received_point)
        end
      end
    end
  end
end

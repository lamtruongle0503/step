# frozen_string_literal: true

class Admin::Hotels::AggregateOrders::CancellationSerializer::AttributesSerializer < ApplicationSerializer
  attributes :id, :order_no, :created_at, :date_cancel, :full_name, :furigana, :check_in, :check_out,
             :person_total, :total, :used_points, :cancellation_fee, :point_return
  belongs_to :coupon, serializer: Admin::Hotels::Coupons::AttributesSerializer

  def full_name
    object.user.full_name
  end

  def furigana
    object.user.furigana
  end

  def point_return
    object.point_usages.map(&:received_point).compact.sum
  end
end

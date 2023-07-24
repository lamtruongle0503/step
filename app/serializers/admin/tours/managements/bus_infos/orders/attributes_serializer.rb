# frozen_string_literal: true

class Admin::Tours::Managements::BusInfos::Orders::AttributesSerializer < ApplicationSerializer
  attributes :id, :order_no, :membership_code, :room, :status
  has_many :tour_order_accompanies,
           serializer: Admin::Tours::Orders::BusInfos::Accompanies::AttributesSerializer

  def membership_code
    return unless object.user.present?

    object.user.code
  end
end

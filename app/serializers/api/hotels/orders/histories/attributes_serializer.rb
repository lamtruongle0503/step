# frozen_string_literal: true

class Api::Hotels::Orders::Histories::AttributesSerializer < ApplicationSerializer
  attributes :id, :order_no, :created_at, :total, :payment_status, :status,
             :hotel_id, :hotel_plan_id, :hotel_room_id, :total_room, :hotel_category
  belongs_to :hotel_room, serializer: Api::Hotels::Rooms::AttributesSerializer

  def hotel_category
    object.hotel.hotel_category.name
  end
end

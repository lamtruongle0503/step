# frozen_string_literal: true

class Admin::Users::Histories::IndexSerializer < ApplicationSerializer
  attributes %i[id code age gender birth_day post_code address1 address2
                telephone note is_dm email nick_name phone_number first_name status
                last_name first_name_kana last_name_kana point orders]

  has_many :tour_orders, serializer: Admin::Users::TourOrders::AttributesSerializer
  has_many :hotel_orders, serializer: Admin::Users::HotelOrders::AttributesSerializer

  def orders
    object.orders.without_awaiting.map do |order|
      Admin::Users::Orders::AttributesSerializer.new(order).as_json
    end
  end
end

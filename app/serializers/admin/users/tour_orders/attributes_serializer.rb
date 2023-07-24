# frozen_string_literal: true

class Admin::Users::TourOrders::AttributesSerializer < ApplicationSerializer
  attributes :id, :order_no, :created_at, :total, :departure_date, :number_people,
             :tour_name, :tour_category, :tour_no, :tour_id

  def created_at
    object.created_at.to_date
  end

  def tour_id
    return unless object.tour_order_log

    object.tour_order_log.tour['id']
  end

  def tour_no
    return unless object.tour_order_log

    object.tour_order_log.tour['code']
  end

  def tour_name
    return unless object.tour_order_log

    object.tour_order_log.tour['name']
  end

  def tour_category
    return unless object.tour_order_log

    category_id = object.tour_order_log.tour['tour_category_id']
    Tour::Category.find(category_id).name if category_id
  end
end

# == Schema Information
#
# Table name: hotel_order_logs
#
#  id                 :bigint           not null, primary key
#  deleted_at         :datetime
#  hotel              :jsonb
#  hotel_order_info   :jsonb
#  hotel_order_params :jsonb
#  plan               :jsonb
#  room               :jsonb
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  hotel_id           :bigint
#  hotel_order_id     :bigint
#  hotel_plan_id      :bigint
#  hotel_room_id      :bigint
#
# Indexes
#
#  index_hotel_order_logs_on_hotel_id        (hotel_id)
#  index_hotel_order_logs_on_hotel_order_id  (hotel_order_id)
#  index_hotel_order_logs_on_hotel_plan_id   (hotel_plan_id)
#  index_hotel_order_logs_on_hotel_room_id   (hotel_room_id)
#
class Hotel::OrderLog < ApplicationRecord
  acts_as_paranoid

  belongs_to :hotel_order, foreign_key: :hotel_order_id, class_name: 'Hotel::Order'
end

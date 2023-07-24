# == Schema Information
#
# Table name: tour_order_logs
#
#  id                         :bigint           not null, primary key
#  amount_tour_bus_seat_map   :jsonb
#  price_special_food         :jsonb
#  price_tour_information     :jsonb
#  tour                       :jsonb
#  tour_cancellation_patterns :jsonb
#  tour_hostels               :string
#  tour_information           :jsonb
#  tour_options               :string
#  tour_stay_departures       :jsonb
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  tour_order_id              :bigint           not null
#
# Indexes
#
#  index_tour_order_logs_on_tour_order_id  (tour_order_id)
#
# Foreign Keys
#
#  fk_rails_...  (tour_order_id => tour_orders.id)
#
class Tour::OrderLog < ApplicationRecord
  belongs_to :tour_order, class_name: 'Tour::Order', foreign_key: :tour_order_id

  serialize :tour_options, Array
end

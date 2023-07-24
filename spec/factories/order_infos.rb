# frozen_string_literal: true

# == Schema Information
#
# Table name: order_infos
#
#  id                  :bigint           not null, primary key
#  buy_name            :string
#  content             :string
#  deleted_at          :datetime
#  delivery_date       :date
#  delivery_end_time   :time
#  delivery_start_time :time
#  email_receiption    :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  address_id          :bigint
#  order_id            :bigint
#
# Indexes
#
#  index_order_infos_on_address_id  (address_id)
#  index_order_infos_on_order_id    (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
FactoryBot.define do
  factory :order_info do
    association :order
    delivery_date { DateTime.current + 5.day }
    delivery_start_time { "#{Faker::Number.between(from: 1, to: 7)}:#{%w[30 00].sample}" }
    delivery_end_time { "#{Faker::Number.between(from: 8, to: 9)}:#{%w[30 00].sample}" }
    content { Faker::Lorem.paragraph }
  end
end

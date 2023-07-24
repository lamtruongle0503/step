# frozen_string_literal: true

# == Schema Information
#
# Table name: delivery_time_settings
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  end_time   :time
#  start_time :time
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint
#
# Indexes
#
#  index_delivery_time_settings_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
FactoryBot.define do
  factory :delivery_time_setting do
    association :product
    start_time { "#{Faker::Number.between(from: 1, to: 7)}:#{%w[30 00].sample}" }
    end_time { "#{Faker::Number.between(from: 8, to: 9)}:#{%w[30 00].sample}" }
  end
end

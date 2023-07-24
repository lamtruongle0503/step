# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    association :user
    code { SecureRandom.hex(3).upcase }
    purchased_amount { rand(10.0..100.0).round(2) }
    delivery_amount { rand(10.0..100.0).round(2) }
    payment_status { (0..2).to_a.sample }
    delivery_status { (0..1).to_a.sample }
    payment_type { (0..2).to_a.sample }
    order_status { (0..5).to_a.sample }
  end
end

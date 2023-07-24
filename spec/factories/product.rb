# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    association :category
    code { rand(1000..9999) }
    name { Faker::Tea.type }
    description { Faker::Lorem.sentence(word_count: 3) }
    discount { Faker::Number.between(from: 10.0, to: 20.0).round 2 }
    is_discount { [true, false].sample }
    colors { Faker::Tea.type }
    remaining_count { rand(1..10) }
    description_info { Faker::Tea.type }
    brand { Faker::Tea.type }
    original_country { Faker::Tea.type }
    distributor { Faker::Tea.type }
    precaution { Faker::Lorem.sentence(word_count: 3) }
    desired_delivery_date { rand(1..3) }
    hash_tag { Faker::Tea.type }
    is_show { [true, false].sample }
    exp_date { rand(1..10).days.since.to_date }
  end
end

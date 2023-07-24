# frozen_string_literal: true

FactoryBot.define do
  factory :campaign do
    name { Faker::Tea.type }
    ranking { rand(50..100) }
  end
end

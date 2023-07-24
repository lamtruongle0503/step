# frozen_string_literal: true

FactoryBot.define do
  factory :area_setting do
    name { Faker::Tea.type }
    code { SecureRandom.hex(3).upcase }
  end
end

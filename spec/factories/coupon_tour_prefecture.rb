# frozen_string_literal: true

FactoryBot.define do
  factory :coupon_tour_prefecture do
    association :coupon_tour
    association :prefecture
  end
end

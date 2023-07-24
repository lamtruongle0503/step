# frozen_string_literal: true

FactoryBot.define do
  factory :coupon_tour do
    start_time { DateTime.current }
    end_time { DateTime.current + 1.day }
    publish_date { DateTime.current + 1.hour }
    association :tour
  end
end

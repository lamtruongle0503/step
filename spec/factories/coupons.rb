# frozen_string_literal: true

# == Schema Information
#
# Table name: coupons
#
#  id             :bigint           not null, primary key
#  deleted_at     :datetime
#  end_time       :date
#  is_notice      :boolean
#  price          :float
#  publish_date   :date
#  start_time     :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  coupon_tour_id :bigint
#
# Indexes
#
#  index_coupons_on_coupon_tour_id  (coupon_tour_id)
#
FactoryBot.define do
  factory :coupon do
    start_time { DateTime.current }
    end_time { DateTime.current + 1.day }
    publish_date { DateTime.current + 1.hour }
    is_notice { false }
  end
end

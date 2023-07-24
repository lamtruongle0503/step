# frozen_string_literal: true

# == Schema Information
#
# Table name: tours_prefectures
#
#  id             :bigint           not null, primary key
#  deleted_at     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  prefecture_id  :bigint
#  tour_coupon_id :integer
#  tour_id        :bigint
#
# Indexes
#
#  index_tours_prefectures_on_prefecture_id  (prefecture_id)
#  index_tours_prefectures_on_tour_id        (tour_id)
#
# Foreign Keys
#
#  fk_rails_...  (prefecture_id => prefectures.id)
#  fk_rails_...  (tour_id => tours.id)
#
FactoryBot.define do
  factory :tours_prefecture do
    association :tour
    association :prefecture
  end
end

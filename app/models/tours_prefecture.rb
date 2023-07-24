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
class ToursPrefecture < ApplicationRecord
  acts_as_paranoid

  belongs_to :tour, optional: true
  belongs_to :tour_coupon, optional: true
  belongs_to :prefecture

  scope :by_prefecture_ids, lambda { |prefecture_ids|
    where(prefecture_id: prefecture_ids)
  }
end

# == Schema Information
#
# Table name: coupon_tour_prefectures
#
#  id             :bigint           not null, primary key
#  deleted_at     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  coupon_tour_id :bigint
#  prefecture_id  :bigint
#
# Indexes
#
#  index_coupon_tour_prefectures_on_coupon_tour_id  (coupon_tour_id)
#  index_coupon_tour_prefectures_on_prefecture_id   (prefecture_id)
#
# Foreign Keys
#
#  fk_rails_...  (coupon_tour_id => coupon_tours.id)
#  fk_rails_...  (prefecture_id => prefectures.id)
#
class CouponTourPrefecture < ApplicationRecord
  acts_as_paranoid

  belongs_to :coupon_tour
  belongs_to :prefecture

  scope :by_prefecture_ids, lambda { |prefecture_ids|
    where(prefecture_id: prefecture_ids)
  }
end

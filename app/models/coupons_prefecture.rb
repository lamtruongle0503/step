# == Schema Information
#
# Table name: coupons_prefectures
#
#  id            :bigint           not null, primary key
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  coupon_id     :bigint
#  prefecture_id :bigint
#
# Indexes
#
#  index_coupons_prefectures_on_coupon_id      (coupon_id)
#  index_coupons_prefectures_on_prefecture_id  (prefecture_id)
#
# Foreign Keys
#
#  fk_rails_...  (coupon_id => coupons.id)
#  fk_rails_...  (prefecture_id => prefectures.id)
#
class CouponsPrefecture < ApplicationRecord
  acts_as_paranoid

  belongs_to :prefecture
  belongs_to :coupon

  scope :by_prefecture_ids, lambda { |prefecture_ids|
    where(prefecture_id: prefecture_ids)
  }
end

# == Schema Information
#
# Table name: coupon_users
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  coupon_id  :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_coupon_users_on_coupon_id  (coupon_id)
#  index_coupon_users_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (coupon_id => coupons.id)
#  fk_rails_...  (user_id => users.id)
#
class CouponUser < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :coupon

  scope :available, lambda {
    joins(:coupon).where(
      ':date BETWEEN coupons.start_time AND coupons.end_time', date: Date.current
    )
  }
end

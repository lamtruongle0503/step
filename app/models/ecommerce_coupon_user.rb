# == Schema Information
#
# Table name: ecommerce_coupon_users
#
#  id         :bigint           not null, primary key
#  is_used    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  coupon_id  :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_ecommerce_coupon_users_on_coupon_id  (coupon_id)
#  index_ecommerce_coupon_users_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (coupon_id => coupons.id)
#  fk_rails_...  (user_id => users.id)
#
class EcommerceCouponUser < ApplicationRecord
  belongs_to :user
  belongs_to :coupon
end

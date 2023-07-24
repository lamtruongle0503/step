# == Schema Information
#
# Table name: coupon_orders
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  coupon_id  :bigint           not null
#  order_id   :bigint           not null
#
# Indexes
#
#  index_coupon_orders_on_coupon_id  (coupon_id)
#  index_coupon_orders_on_order_id   (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (coupon_id => coupons.id)
#  fk_rails_...  (order_id => orders.id)
#
class CouponOrder < ApplicationRecord
  belongs_to :coupon
  belongs_to :order
end

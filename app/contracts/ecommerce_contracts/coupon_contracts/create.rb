# frozen_string_literal: true

class EcommerceContracts::CouponContracts::Create < EcommerceContracts::CouponContracts::Base
  validates :user_id, existence: User.name
  validates :coupon_id, existence: Coupon.name

  validate :coupon_valid

  def coupon_valid
    coupon = EcommerceCouponUser.exists?(user_id: user_id, coupon_id: coupon_id)
    return unless coupon

    errors.add(:coupon_id, I18n.t('models.exists')) if coupon
  end
end

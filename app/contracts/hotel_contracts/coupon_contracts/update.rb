# frozen_string_literal: true

class HotelContracts::CouponContracts::Update < HotelContracts::CouponContracts::Base
  attribute :id, Integer
  attribute :coupon_ids, Array

  validates :id, presence: true, existence: Coupon.name
  validate :exist_coupon_in_hotel

  def exist_coupon_in_hotel
    return if coupon_ids.include?(id)

    errors.add :id, I18n.t('models.does_not_exists')
  end
end

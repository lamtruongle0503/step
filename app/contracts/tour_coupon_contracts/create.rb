# frozen_string_literal: true

class TourCouponContracts::Create < TourCouponContracts::Base
  validates :code, presence: true, uniqueness: { model: TourCoupon }
end

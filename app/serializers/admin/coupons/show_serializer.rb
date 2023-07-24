# frozen_string_literal: true

class Admin::Coupons::ShowSerializer < Admin::Coupons::AttributesSerializer
  has_many :assets, serializer: Assets::AttributesSerializer
end

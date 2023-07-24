# frozen_string_literal: true

class Admin::CouponTours::Coupons::AttributesSerializer < ApplicationSerializer
  attributes :id, :asssets

  def asssets
    object.assets.map { |asset| Assets::AttributesSerializer.new(asset).as_json }
  end
end

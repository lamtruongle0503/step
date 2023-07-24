# frozen_string_literal: true

class Admin::Coupons::Tours::AttributesSerializer < ApplicationSerializer
  attributes :id, :start_time, :end_time, :price
end

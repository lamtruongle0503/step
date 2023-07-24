# frozen_string_literal: true

class Admin::Tours::Orders::BusInfos::AttributesSerializer < ApplicationSerializer
  attributes :id, :discount_amount, :initial_price, :total
end

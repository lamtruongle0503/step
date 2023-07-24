# frozen_string_literal: true

class Admin::Tours::OrderSpecials::Search::IndexSerializer < ApplicationSerializer
  attributes :id, :order_no, :memo
  has_many :tour_order_accompanies, serializer: Admin::Tours::Orders::OrderAccompanies::AttributesSerializer
end

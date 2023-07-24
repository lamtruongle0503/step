# frozen_string_literal: true

class Api::Hotels::Coupons::AttributesSerializer < ApplicationSerializer
  attributes :id, :start_time, :end_time, :publish_date, :price
end

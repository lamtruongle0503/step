# frozen_string_literal: true

class Api::Users::Coupons::IndexSerializer < ApplicationSerializer
  attributes :id, :start_time, :end_time, :publish_date, :price, :product_name

  def product_name
    object&.products&.first&.name
  end
end

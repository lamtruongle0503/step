# frozen_string_literal: true

require 'tour/order'
class Api::TourOperations::OrderOperations::SearchOperations::Index < ApplicationOperation
  def call
    Tour::Order.find_by!(order_no: params[:order_no])
  end
end

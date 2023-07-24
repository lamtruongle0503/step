# frozen_string_literal: true

require 'tour/order'
class Admin::TourOperations::OrderOperations::Show < ApplicationOperation
  def call
    authorize nil, Tour::Management::OrderPolicy

    Tour::Order.find(params[:id])
  end
end

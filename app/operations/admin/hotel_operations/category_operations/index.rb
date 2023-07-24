# frozen_string_literal: true

class Admin::HotelOperations::CategoryOperations::Index < ApplicationOperation
  def call
    Hotel::Category.all
  end
end

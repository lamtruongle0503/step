# frozen_string_literal: true

class Admin::HotelOperations::MetaOperations::Index < ApplicationOperation
  def call
    Hotel.posting
  end
end

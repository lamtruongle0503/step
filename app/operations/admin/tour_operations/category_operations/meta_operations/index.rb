# frozen_string_literal: true

class Admin::TourOperations::CategoryOperations::MetaOperations::Index < ApplicationOperation
  def call
    Tour::Category.all
  end
end

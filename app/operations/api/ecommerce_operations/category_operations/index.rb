# frozen_string_literal: true

class Api::EcommerceOperations::CategoryOperations::Index < ApplicationOperation
  def call
    Category.includes(:asset).order(:ranking)
  end
end

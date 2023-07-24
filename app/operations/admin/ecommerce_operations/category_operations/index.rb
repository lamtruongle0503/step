# frozen_string_literal: true

class Admin::EcommerceOperations::CategoryOperations::Index < ApplicationOperation
  def call
    authorize nil, Ecommerces::CategoryPolicy

    Category.includes(:asset).order(:ranking)
  end
end

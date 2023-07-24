# frozen_string_literal: true

class Api::EcommerceOperations::CategoryOperations::MetaOperations::Index < ApplicationOperation
  def call
    Category.all
  end
end

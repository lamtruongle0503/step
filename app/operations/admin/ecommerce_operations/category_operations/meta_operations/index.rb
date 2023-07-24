# frozen_string_literal: true

class Admin::EcommerceOperations::CategoryOperations::MetaOperations::Index < ApplicationOperation
  def call
    Category.all
  end
end

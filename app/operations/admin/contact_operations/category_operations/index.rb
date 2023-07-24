# frozen_string_literal: true

class Admin::ContactOperations::CategoryOperations::Index < ApplicationOperation
  def call
    ContactCategory.all.order(:id)
  end
end

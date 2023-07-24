# frozen_string_literal: true

class Api::EcommerceOperations::CategoryOperations::Show < ApplicationOperation
  def call
    Category.find(params[:id])
  end
end

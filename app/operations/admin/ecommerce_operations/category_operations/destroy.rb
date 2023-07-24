# frozen_string_literal: true

class Admin::EcommerceOperations::CategoryOperations::Destroy < ApplicationOperation
  def call
    authorize nil, Ecommerces::CategoryPolicy

    Category.find(params[:id])&.destroy!
  end
end

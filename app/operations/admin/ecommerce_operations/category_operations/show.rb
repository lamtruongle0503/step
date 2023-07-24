# frozen_string_literal: true

class Admin::EcommerceOperations::CategoryOperations::Show < ApplicationOperation
  def call
    authorize nil, Ecommerces::CategoryPolicy

    Category.includes(:asset).find(params[:id])
  end
end

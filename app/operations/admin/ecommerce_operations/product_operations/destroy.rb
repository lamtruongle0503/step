# frozen_string_literal: true

class Admin::EcommerceOperations::ProductOperations::Destroy < ApplicationOperation
  def call
    authorize nil, Ecommerces::ProductPolicy

    Product.find(params[:id]).destroy!
  end
end

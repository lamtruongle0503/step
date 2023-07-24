# frozen_string_literal: true

class Admin::EcommerceOperations::ProductOperations::MetaOperations::Show < ApplicationOperation
  def call
    Product.find(params[:id])
  end
end

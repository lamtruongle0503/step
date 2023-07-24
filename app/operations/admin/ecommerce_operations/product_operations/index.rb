# frozen_string_literal: true

class Admin::EcommerceOperations::ProductOperations::Index < ApplicationOperation
  def call
    authorize nil, Ecommerces::ProductPolicy

    @q        = Product.includes(:category, :assets, :product_sizes).ransack(params[:q])
    @contacts = @q.result(distinct: true).newest.page(params[:page])
  end
end

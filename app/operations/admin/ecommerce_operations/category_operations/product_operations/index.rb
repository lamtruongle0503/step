# frozen_string_literal: true

class Admin::EcommerceOperations::CategoryOperations::ProductOperations::Index < ApplicationOperation
  def call
    category = Category.find(params[:category_id])
    category.products.includes(:assets, :product_sizes).page(params[:page])
  end
end

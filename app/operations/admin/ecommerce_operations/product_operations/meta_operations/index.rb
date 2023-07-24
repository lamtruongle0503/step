# frozen_string_literal: true

class Admin::EcommerceOperations::ProductOperations::MetaOperations::Index < ApplicationOperation
  def call
    Product.by_category(params[:category_id])
  end
end

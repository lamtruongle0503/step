# frozen_string_literal: true

class Admin::EcommerceOperations::ProductOperations::Show < ApplicationOperation
  def call
    authorize nil, Ecommerces::ProductPolicy

    Product.includes(:coupon, :agency, product_area_settings: [:area_setting]).find(params[:id])
  end
end

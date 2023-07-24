# frozen_string_literal: true

class Admin::EcommerceOperations::ProductOperations::StatusOperations::Update < ApplicationOperation
  attr_reader :product

  def initialize(actor, params)
    super
    @product = Product.find(params[:product_id])
  end

  def call
    EcommerceContracts::ProductContracts::StatusContracts::Update.new(product_params).valid!
    product.update!(product_params)
  end

  private

  def product_params
    params.permit(:is_show)
  end
end

# frozen_string_literal: true

class Api::EcommerceOperations::CartOperations::Index < ApplicationOperation
  attr_reader :user

  def initialize(actor, params)
    super
    @user = actor
  end

  def call
    user.orders.waiting.includes(:agency, order_products: [product: :assets]).page(params[:page])
  end
end

# frozen_string_literal: true

class Admin::EcommerceOperations::OrderOperations::Show < ApplicationOperation
  def call
    authorize nil, Ecommerces::OrderPolicy

    Order.find(params[:id])
  end
end

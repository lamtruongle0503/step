# frozen_string_literal: true

class Admin::EcommerceOperations::AgencyOperations::Show < ApplicationOperation
  def call
    authorize nil, Ecommerces::AgencyPolicy

    Agency.find(params[:id])
  end
end

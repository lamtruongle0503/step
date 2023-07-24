# frozen_string_literal: true

class Admin::EcommerceOperations::AgencyOperations::Destroy < ApplicationOperation
  def call
    authorize nil, Ecommerces::AgencyPolicy

    Agency.find(params[:id])&.destroy!
  end
end

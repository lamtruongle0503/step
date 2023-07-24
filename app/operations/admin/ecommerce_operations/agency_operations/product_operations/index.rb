# frozen_string_literal: true

class Admin::EcommerceOperations::AgencyOperations::ProductOperations::Index < ApplicationOperation
  attr_reader :agency

  def initialize(actor, params)
    super
    @agency = Agency.find(params[:agency_id])
  end

  def call
    authorize nil, Ecommerces::AgencyPolicy

    agency.products.includes(:assets, :category, :product_sizes).page(params[:page])
  end
end

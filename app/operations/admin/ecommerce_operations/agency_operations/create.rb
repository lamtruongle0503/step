# frozen_string_literal: true

class Admin::EcommerceOperations::AgencyOperations::Create < ApplicationOperation
  def call
    authorize nil, Ecommerces::AgencyPolicy

    EcommerceContracts::AgencyContracts::Create.new(agency_params).valid!
    ActiveRecord::Base.transaction do
      create_agency!
    end
  end

  private

  def create_agency!
    Agency.create!(agency_params)
  end

  def agency_params
    params.permit(:code, :name, :email, :address, :contact_address, :person, :company_name,
                  :is_free, :fee_shipping, payment_ids: [], delivery_ids: [])
  end
end

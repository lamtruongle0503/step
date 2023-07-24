# frozen_string_literal: true

class Admin::EcommerceOperations::AgencyOperations::Update < ApplicationOperation
  attr_reader :agency

  def initialize(actor, params)
    super
    @agency = Agency.find(params[:id])
  end

  def call
    authorize nil, Ecommerces::AgencyPolicy

    EcommerceContracts::AgencyContracts::Update.new(agency_params.merge!(record: agency)).valid!
    update_agency!
  end

  private

  def update_agency!
    agency.update!(agency_params)
  end

  def update_agency_payment(agency)
    new_payment_ids = params[:payment_ids] - agency.agency_payments.pluck(:payment_id)
    remove_payment_ids = agency.agency_payments.pluck(:payment_id) - params[:payment_ids]
    agency.agency_payments.where(payment_id: remove_payment_ids).destroy_all!
    new_payment_ids.each do |payment_id|
      agency.agency_payments.create!(delivery_id: payment_id)
    end
  end

  def update_agency_delivery(agency)
    new_delivery_ids = params[:delivery_ids] - agency.agency_payments.pluck(:delivery_id)
    remove_delivery_ids = agency.agency_deliveries.pluck(:delivery_id) - params[:delivery_ids]
    agency.agency_deliveries.where(deliveries: remove_delivery_ids).destroy_all!
    new_delivery_ids.each do |payment_id|
      agency.agency_payments.create!(delivery_id: payment_id)
    end
  end

  def agency_params
    params.permit(:code, :name, :email, :address, :contact_address, :person, :is_free, :fee_shipping,
                  :company_name, payment_ids: [], delivery_ids: [])
  end
end

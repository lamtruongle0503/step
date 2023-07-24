# frozen_string_literal: true

require 'tour/company'
class Admin::TourOperations::CompanyOperations::Update < ApplicationOperation
  attr_reader :tour_company

  def initialize(actor, params)
    super
    @tour_company = Tour::Company.find(params[:id])
  end

  def call
    authorize nil, Tour::CompanyPolicy

    ActiveRecord::Base.transaction do
      update_tour_company!
    end
  end

  private

  def update_tour_company!
    TourContracts::CompanyContracts::Update.new(tour_company_params.merge(tour_company: tour_company)).valid!
    tour_company.update!(tour_company_params)
  end

  def tour_company_params
    params.permit(:name, :address1, :address2, :email, :note, :postal_code, :telephone)
  end
end

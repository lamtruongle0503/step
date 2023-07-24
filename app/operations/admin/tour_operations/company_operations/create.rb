# frozen_string_literal: true

require 'tour/company'
class Admin::TourOperations::CompanyOperations::Create < ApplicationOperation
  def call
    authorize nil, Tour::CompanyPolicy

    ActiveRecord::Base.transaction do
      create_tour_company!
    end
  end

  private

  def create_tour_company!
    TourContracts::CompanyContracts::Create.new(tour_company_params).valid!
    Tour::Company.create!(tour_company_params)
  end

  def tour_company_params
    params.permit(:name, :address1, :address2, :email, :note, :postal_code, :telephone)
  end
end

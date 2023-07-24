# frozen_string_literal: true

require 'tour/company'
class Admin::TourOperations::CompanyOperations::Show < ApplicationOperation
  def call
    authorize nil, Tour::CompanyPolicy

    @tour_company = Tour::Company.find(params[:id])
  end
end

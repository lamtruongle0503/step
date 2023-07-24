# frozen_string_literal: true

require 'tour/company'
class Admin::TourOperations::CompanyOperations::Destroy < ApplicationOperation
  def call
    authorize nil, Tour::CompanyPolicy

    Tour::Company.find(params[:id])&.destroy
  end
end

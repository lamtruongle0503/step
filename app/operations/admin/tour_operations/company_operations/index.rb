# frozen_string_literal: true

require 'tour/company'
class Admin::TourOperations::CompanyOperations::Index < ApplicationOperation
  def call
    authorize nil, Tour::CompanyPolicy

    @q = Tour::Company.ransack(params[:q])
    @q.result(distinct: true).newest.page(params[:page])
  end
end

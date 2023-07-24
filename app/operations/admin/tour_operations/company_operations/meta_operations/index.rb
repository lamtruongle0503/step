# frozen_string_literal: true

require 'tour/company'
class Admin::TourOperations::CompanyOperations::MetaOperations::Index < ApplicationOperation
  def call
    @q = Tour::Company.ransack(params[:q])
    @q.result(distinct: true)
  end
end

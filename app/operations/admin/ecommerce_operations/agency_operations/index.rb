# frozen_string_literal: true

class Admin::EcommerceOperations::AgencyOperations::Index < ApplicationOperation
  def call
    authorize nil, Ecommerces::AgencyPolicy

    @q = Agency.ransack(params[:q])
    @q.result(distinct: true).includes(:payments, :deliveries).newest.page(params[:page])
  end
end

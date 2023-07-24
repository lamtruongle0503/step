# frozen_string_literal: true

class Admin::LifeSupportOperations::Show < ApplicationOperation
  def call
    authorize nil, LifeSupportPolicy

    @life_support = LifeSupport.find(params[:id])
  end
end

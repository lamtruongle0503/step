# frozen_string_literal: true

class Admin::LifeSupportOperations::Destroy < ApplicationOperation
  def call
    authorize nil, LifeSupportPolicy

    life_support = LifeSupport.find(params[:id])
    life_support.destroy!
  end
end

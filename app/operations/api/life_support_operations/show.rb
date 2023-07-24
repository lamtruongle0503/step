# frozen_string_literal: true

class Api::LifeSupportOperations::Show < ApplicationOperation
  def call
    LifeSupport.find(params[:id])
  end
end

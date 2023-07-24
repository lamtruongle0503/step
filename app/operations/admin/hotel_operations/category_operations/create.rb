# frozen_string_literal: true

class Admin::HotelOperations::CategoryOperations::Create < ApplicationOperation
  def call
    HotelContracts::CategoryContracts::Create.new(category_params).valid!
    ActiveRecord::Base.transaction do
      Hotel::Category.create!(category_params)
    end
  end

  private

  def category_params
    params.permit(:code, :name)
  end
end

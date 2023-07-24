# frozen_string_literal: true

class Api::DistrictOperations::Index < ApplicationOperation
  def call
    District.where(prefecture_id: params[:prefecture_id])
  end
end

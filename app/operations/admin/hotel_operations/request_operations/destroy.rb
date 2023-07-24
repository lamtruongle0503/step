# frozen_string_literal: true

class Admin::HotelOperations::RequestOperations::Destroy < ApplicationOperation
  def initialize(actor, params)
    super
    @request = Hotel::Request.find(params[:id])
  end

  def call
    authorize nil, Hotel::RequestPolicy

    ActiveRecord::Base.transaction do
      @request.destroy!
    end
  end
end

# frozen_string_literal: true

class Admin::HotelOperations::CancellationPolicyOperations::Destroy < ApplicationOperation
  def initialize(actor, params)
    super
    @cancel = Hotel::CancellationPolicy.find(params[:id])
  end

  def call
    authorize nil, Hotel::CancellationPolicyPolicy

    ActiveRecord::Base.transaction do
      @cancel.destroy!
    end
  end
end

# frozen_string_literal: true

require 'hotel/cancellation_policy'
require 'hotel/cancellation_detail'
class Admin::HotelOperations::CancellationDetailOperations::Destroy < ApplicationOperation
  def call
    authorize nil, Hotel::CancellationPolicyPolicy

    ActiveRecord::Base.transaction do
      Hotel::CancellationDetail.find(params[:id])&.destroy
    end
  end
end

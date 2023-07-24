# frozen_string_literal: true

require 'hotel/cancellation_policy'
require 'hotel/cancellation_detail'
class Admin::HotelOperations::CancellationPolicyOperations::Show < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
  end

  def call
    authorize nil, Hotel::CancellationPolicyPolicy

    @hotel.hotel_cancellation_policies.find(params[:id])
  end
end

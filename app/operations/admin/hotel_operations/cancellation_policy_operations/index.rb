# frozen_string_literal: true

class Admin::HotelOperations::CancellationPolicyOperations::Index < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:id])
  end

  def call
    authorize nil, Hotel::CancellationPolicyPolicy

    @hotel.hotel_cancellation_policies.newest
  end
end

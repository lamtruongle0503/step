# frozen_string_literal: true

require 'hotel/cancellation_policy'
class Admin::HotelOperations::CancellationPolicyOperations::MetaOperations::Index < ApplicationOperation
  def call
    Hotel.find(params[:hotel_id]).hotel_cancellation_policies.includes(:hotel_cancellation_details).use
  end
end

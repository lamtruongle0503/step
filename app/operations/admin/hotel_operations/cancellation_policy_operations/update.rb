# frozen_string_literal: true

require 'hotel/cancellation_policy'
require 'hotel/cancellation_detail'
class Admin::HotelOperations::CancellationPolicyOperations::Update < ApplicationOperation
  attr_reader :hotel_cancellation

  def initialize(actor, params)
    super
    @hotel_cancellation = Hotel::CancellationPolicy.find(params[:id])
  end

  def call
    authorize nil, Hotel::CancellationPolicyPolicy

    ActiveRecord::Base.transaction do
      update_hotel_cancellation
    end
  end

  private

  def update_hotel_cancellation
    HotelContracts::CancellationPolicyContracts::Update.new(cancellation_params).valid!
    hotel_cancellation.update!(cancellation_params)
  end

  def cancellation_params
    params.permit(:cxl_management_name, :date_free_cancellation, :is_use, :created_at, :updated_at)
  end
end

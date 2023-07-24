# frozen_string_literal: true

require 'hotel/cancellation_detail'
class Admin::HotelOperations::CancellationDetailOperations::Update < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
    @hotel_cancellation_policy = @hotel.hotel_cancellation_policies.find(params[:cancellation_policy_id])
    @hotel_cancellation_detail = Hotel::CancellationDetail.find(params[:id])
  end

  def call
    authorize nil, Hotel::CancellationPolicyPolicy

    ActiveRecord::Base.transaction do
      update_cancellation_detail(@hotel_cancellation_detail)
    end
  end

  private

  def update_cancellation_detail(_hotel_cancellation_detail)
    HotelContracts::CancellationDetailContracts::Update.new(
      cancellation_detail_params.merge(
        date_free_cancellation: @hotel_cancellation_policy.date_free_cancellation,
      ),
    ).valid!
    @hotel_cancellation_detail.update!(cancellation_detail_params)
  end

  def cancellation_detail_params
    params.permit(:name, :flg1, :flg2, :unit, :value)
  end
end

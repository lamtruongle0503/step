# frozen_string_literal: true

require 'hotel/cancellation_policy'
require 'hotel/cancellation_detail'
class Admin::HotelOperations::CancellationDetailOperations::Create < ApplicationOperation
  def call
    authorize nil, Hotel::CancellationPolicyPolicy

    ActiveRecord::Base.transaction do
      hotel_cancellation_policy = Hotel::CancellationPolicy.find(params[:cancellation_policy_id])
      create_cancellation_detail(hotel_cancellation_policy)
    end
  end

  private

  def create_cancellation_detail(hotel_cancellation_policy)
    HotelContracts::CancellationDetailContracts::Create
      .new(cancellation_detail_params.merge(
             date_free_cancellation: hotel_cancellation_policy.date_free_cancellation,
           )).valid!
    hotel_cancellation_policy.hotel_cancellation_details.create!(cancellation_detail_params)
  end

  def cancellation_detail_params
    params.permit(:name, :flg1, :flg2, :unit, :value)
  end
end

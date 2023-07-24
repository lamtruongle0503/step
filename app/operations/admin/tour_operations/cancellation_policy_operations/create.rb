# frozen_string_literal: true

require 'tour/cancellation_policy'
require 'tour/cancellation_detail'
class Admin::TourOperations::CancellationPolicyOperations::Create < ApplicationOperation
  def call
    authorize nil, Tour::Management::CancellationPolicyPolicy

    ActiveRecord::Base.transaction do
      create_tour_cancellation_policy!
    end
  end

  private

  def create_tour_cancellation_policy!
    TourContracts::CancellationPolicyContracts::Create.new(tour_cancellation_policy_params).valid!
    Tour::CancellationPolicy.create!(tour_cancellation_policy_params)
  end

  def tour_cancellation_policy_params
    params.permit(:name, tour_cancellation_details_attributes: %i[name flg1 flg2 unit value])
  end
end

# frozen_string_literal: true

require 'tour/cancellation_policy'
class Admin::TourOperations::CancellationDetailOperations::Update < ApplicationOperation
  def call
    authorize nil, Tour::Management::CancellationPolicyPolicy

    tour_cancellation_detail = Tour::CancellationDetail.find(params[:id])
    ActiveRecord::Base.transaction do
      update_cancellation_detail(tour_cancellation_detail)
    end
  end

  private

  def update_cancellation_detail(tour_cancellation_detail)
    TourContracts::CancellationDetailContracts::Update.new(cancellation_detail_params).valid!
    tour_cancellation_detail.update!(cancellation_detail_params)
  end

  def cancellation_detail_params
    params.permit(:name, :flg1, :flg2, :unit, :value)
  end
end

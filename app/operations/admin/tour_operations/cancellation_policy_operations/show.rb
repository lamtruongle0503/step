# frozen_string_literal: true

require 'tour/cancellation_policy'
require 'tour/cancellation_detail'
class Admin::TourOperations::CancellationPolicyOperations::Show < ApplicationOperation
  def call
    authorize nil, Tour::Management::CancellationPolicyPolicy

    @tour_cancellation_policy = Tour::CancellationPolicy.find(params[:id])
  end
end

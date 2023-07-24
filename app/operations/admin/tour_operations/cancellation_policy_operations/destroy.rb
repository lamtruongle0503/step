# frozen_string_literal: true

require 'tour/cancellation_policy'
class Admin::TourOperations::CancellationPolicyOperations::Destroy < ApplicationOperation
  def call
    authorize nil, Tour::Management::CancellationPolicyPolicy

    Tour::CancellationPolicy.find(params[:id])&.destroy
  end
end

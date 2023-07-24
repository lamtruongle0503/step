# frozen_string_literal: true

require 'tour/cancellation_policy'
require 'tour/cancellation_detail'
class Admin::TourOperations::CancellationDetailOperations::Destroy < ApplicationOperation
  def call
    authorize nil, Tour::Management::CancellationPolicyPolicy

    Tour::CancellationDetail.find(params[:id])&.destroy
  end
end

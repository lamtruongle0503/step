# frozen_string_literal: true

require 'tour/cancellation_policy'
require 'tour/cancellation_detail'
class Admin::TourOperations::CancellationPolicyOperations::Index < ApplicationOperation
  def call
    authorize nil, Tour::Management::CancellationPolicyPolicy

    @q = Tour::CancellationPolicy.includes(:tour_cancellation_details).ransack(params[:q])
    @q.result(distinct: true).newest.page(params[:page])
  end
end

# frozen_string_literal: true

require 'tour/cancellation_policy'
class Admin::TourOperations::CancellationPolicyOperations::MetaOperations::Index < ApplicationOperation
  def call
    @tour_cancellation_policies = Tour::CancellationPolicy.all.newest
  end
end

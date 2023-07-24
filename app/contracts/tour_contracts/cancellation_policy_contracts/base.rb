# frozen_string_literal: true

class TourContracts::CancellationPolicyContracts::Base < ApplicationContract
  attribute :name,                                   String
  attribute :tour_cancellation_details_attributes,   Array
  validates :name, presence: true
end

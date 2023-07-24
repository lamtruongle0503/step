# frozen_string_literal: true

class Api::Tours::CancellationPolicies::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :tour_cancellation_details

  def tour_cancellation_details
    object.tour_cancellation_details.map do |cancellation_detail|
      Api::Tours::CancellationDetails::AttributesSerializer.new(cancellation_detail).as_json
    end
  end
end

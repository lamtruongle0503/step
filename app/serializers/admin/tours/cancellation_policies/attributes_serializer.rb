# frozen_string_literal: true

class Admin::Tours::CancellationPolicies::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :tour_cancellation_details

  def tour_cancellation_details
    object.tour_cancellation_details.map do |tour_cancellation_detail|
      Admin::Tours::CancellationDetails::IndexSerializer.new(tour_cancellation_detail).as_json
    end
  end
end

# frozen_string_literal: true

class Api::Hotels::CancellationPolicies::AttributesSerializer < ApplicationSerializer
  attributes :id, :cxl_management_name, :date_free_cancellation, :is_use, :hotel_cancellation_details

  def hotel_cancellation_details
    object.hotel_cancellation_details.map do |obj|
      Api::Hotels::CancellationDetails::AttributesSerializer.new(obj).as_json
    end
  end
end

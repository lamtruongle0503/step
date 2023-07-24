# frozen_string_literal: true

class Admin::Hotels::CancellationPolicies::AttributesSerializer < ApplicationSerializer
  attributes :id, :cxl_management_name, :date_free_cancellation, :is_use
  has_many :hotel_cancellation_details, serializer: Admin::Hotels::CancellationDetails::AttributesSerializer
end

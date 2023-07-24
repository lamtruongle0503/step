# frozen_string_literal: true

class Admin::Hotels::CancellationPolicies::ShowSerializer <
      Admin::Hotels::CancellationPolicies::AttributesSerializer
  attributes :created_at, :updated_at
  has_many :hotel_cancellation_details, serializer: Admin::Hotels::CancellationDetails::AttributesSerializer

  def created_at
    return unless object.created_at

    object.created_at.to_date
  end

  def updated_at
    return unless object.updated_at

    object.updated_at.to_date
  end
end

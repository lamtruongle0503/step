# frozen_string_literal: true

class TourContracts::CancellationPolicyContracts::Create < TourContracts::CancellationPolicyContracts::Base
  validates :tour_cancellation_details, presence: true

  def tour_cancellation_details
    tour_cancellation_details_attributes.each do |obj|
      TourContracts::CancellationDetailContracts::Create.new(obj).valid!
    end
  end
end

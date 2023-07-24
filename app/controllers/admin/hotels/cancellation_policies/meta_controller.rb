# frozen_string_literal: true

class Admin::Hotels::CancellationPolicies::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    hotel_cancellation_policies =
      Admin::HotelOperations::CancellationPolicyOperations::MetaOperations::Index.new(actor, params).call
    render json: hotel_cancellation_policies,
           each_serializer: Admin::Hotels::CancellationPolicies::ShowSerializer,
           root: 'data', adapter: :json
  end
end

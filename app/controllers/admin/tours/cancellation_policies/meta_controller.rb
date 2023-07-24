# frozen_string_literal: true

class Admin::Tours::CancellationPolicies::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    tour_cancellation_policies =
      Admin::TourOperations::CancellationPolicyOperations::MetaOperations::Index.new(actor, params).call
    render json: tour_cancellation_policies,
           each_serializer: Admin::Tours::CancellationPolicies::Meta::IndexSerializer,
           root: 'data', adapter: :json
  end
end

# frozen_string_literal: true

class Admin::Tours::CancellationPoliciesController < ApiV1Controller
  before_action :authentication!

  def create
    Admin::TourOperations::CancellationPolicyOperations::Create.new(actor, params).call
    render json: {}
  end

  def index
    tour_cancellation_policies = Admin::TourOperations::CancellationPolicyOperations::Index.new(actor,
                                                                                                params).call
    render json: tour_cancellation_policies,
           each_serializer: Admin::Tours::CancellationPolicies::IndexSerializer,
           meta: pagination_dict(tour_cancellation_policies), root: 'data', adapter: :json
  end

  def show
    tour_cancellation_policy = Admin::TourOperations::CancellationPolicyOperations::Show.new(actor,
                                                                                             params).call
    render json:       tour_cancellation_policy,
           serializer: Admin::Tours::CancellationPolicies::ShowSerializer
  end

  def destroy
    Admin::TourOperations::CancellationPolicyOperations::Destroy.new(actor, params).call
    render json: {}
  end
end

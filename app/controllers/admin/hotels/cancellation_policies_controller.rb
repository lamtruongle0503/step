# frozen_string_literal: true

class Admin::Hotels::CancellationPoliciesController < ApiV1Controller
  before_action :authentication!

  def create
    Admin::HotelOperations::CancellationPolicyOperations::Create.new(actor, params).call
    render json: {}
  end

  def index
    cancellations = Admin::HotelOperations::CancellationPolicyOperations::Index.new(actor, params).call
    render json: cancellations, each_serializer: Admin::Hotels::CancellationPolicies::IndexSerializer
  end

  def destroy
    Admin::HotelOperations::CancellationPolicyOperations::Destroy.new(actor, params).call
    render json: {}
  end

  def update
    Admin::HotelOperations::CancellationPolicyOperations::Update.new(actor, params).call
    render json: {}
  end

  def show
    cancellation = Admin::HotelOperations::CancellationPolicyOperations::Show.new(actor, params).call
    render json:       cancellation,
           serializer: Admin::Hotels::CancellationPolicies::ShowSerializer
  end
end

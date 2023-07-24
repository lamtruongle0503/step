# frozen_string_literal: true

class Admin::Tours::CancellationDetailsController < ApiV1Controller
  before_action :authentication!

  def create
    Admin::TourOperations::CancellationDetailOperations::Create.new(actor, params).call
    render json: {}
  end

  def destroy
    Admin::TourOperations::CancellationDetailOperations::Destroy.new(actor, params).call
    render json: {}
  end

  def update
    Admin::TourOperations::CancellationDetailOperations::Update.new(actor, params).call
    render json: {}
  end
end

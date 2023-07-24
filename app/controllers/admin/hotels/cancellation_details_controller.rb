# frozen_string_literal: true

class Admin::Hotels::CancellationDetailsController < ApiV1Controller
  before_action :authentication!

  def create
    Admin::HotelOperations::CancellationDetailOperations::Create.new(actor, params).call
    render json: {}
  end

  def destroy
    Admin::HotelOperations::CancellationDetailOperations::Destroy.new(actor, params).call
    render json: {}
  end

  def update
    Admin::HotelOperations::CancellationDetailOperations::Update.new(actor, params).call
    render json: {}
  end
end

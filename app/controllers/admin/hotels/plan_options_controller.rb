# frozen_string_literal: true

class Admin::Hotels::PlanOptionsController < ApiV1Controller
  before_action :authentication!

  def create
    Admin::HotelOperations::PlanOptionOperations::Create.new(actor, params).call
    render json: {}
  end

  def index
    hotel_plan_option = Admin::HotelOperations::PlanOptionOperations::Index.new(actor, params).call
    render json: hotel_plan_option, serializer: Admin::Hotels::PlanOptions::IndexSerializer
  end

  def show
    hotel_plan_option = Admin::HotelOperations::PlanOptionOperations::Show.new(actor, params).call
    render json: hotel_plan_option, serializer: Admin::Hotels::PlanOptions::ShowSerializer
  end

  def destroy
    Admin::HotelOperations::PlanOptionOperations::Destroy.new(actor, params).call
    render json: {}
  end

  def update
    Admin::HotelOperations::PlanOptionOperations::Update.new(actor, params).call
    render json: {}
  end
end

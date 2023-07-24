# frozen_string_literal: true

class Admin::Hotels::PlansController < ApiV1Controller
  before_action :authentication!

  def create
    Admin::HotelOperations::PlanOperations::Create.new(actor, params).call
    render json: {}
  end

  def update
    Admin::HotelOperations::PlanOperations::Update.new(actor, params).call
    render json: {}
  end

  def destroy
    Admin::HotelOperations::PlanOperations::Destroy.new(actor, params).call
    render json: {}
  end

  def show
    hotel_plan = Admin::HotelOperations::PlanOperations::Show.new(actor, params).call
    render json: hotel_plan, serializer: Admin::Hotels::Plans::ShowSerializer
  end

  def index
    hotel_plans = Admin::HotelOperations::PlanOperations::Index.new(actor, params).call
    render json: hotel_plans, each_serializer: Admin::Hotels::Plans::IndexSerializer,
           root: 'hotel_plans'
  end
end

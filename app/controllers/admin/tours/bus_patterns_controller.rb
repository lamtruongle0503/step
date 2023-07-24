# frozen_string_literal: true

class Admin::Tours::BusPatternsController < ApiV1Controller
  before_action :authentication!

  def show
    tour_bus_pattern = Admin::TourOperations::BusPatternOperations::Show.new(actor, params).call
    render json:       tour_bus_pattern,
           serializer: Admin::Tours::BusPatterns::ShowSerializer
  end

  def create
    tour_bus_pattern = Admin::TourOperations::BusPatternOperations::Create.new(actor, params).call
    render json:       tour_bus_pattern,
           serializer: Admin::Tours::BusPatterns::CreateSerializer
  end

  def update
    Admin::TourOperations::BusPatternOperations::Update.new(actor, params).call
    render json: {}
  end

  def destroy
    Admin::TourOperations::BusPatternOperations::Destroy.new(actor, params).call
    render json: {}
  end
end

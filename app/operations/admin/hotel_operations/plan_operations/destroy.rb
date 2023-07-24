# frozen_string_literal: true

class Admin::HotelOperations::PlanOperations::Destroy < ApplicationOperation
  attr_reader :hotel_plan

  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
    @hotel_plan = @hotel.hotel_plans.find(params[:id])
  end

  def call
    authorize nil, Hotel::PlanPolicy

    if hotel_plan.hotel_orders.present?
      return raise BadRequestError,
                   hotel_plan: I18n.t('hotels.plans.reserved')
    end

    ActiveRecord::Base.transaction do
      @hotel_plan.destroy!
    end
  end
end

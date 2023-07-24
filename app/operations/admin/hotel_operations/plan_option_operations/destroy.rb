# frozen_string_literal: true

class Admin::HotelOperations::PlanOptionOperations::Destroy < ApplicationOperation
  def initialize(actor, params)
    super
    require_params
    @hotel = Hotel.find(params[:hotel_id])
    @hotel_plan = @hotel.hotel_plans.find(params[:plan_id])
    @hotel_plan_option = @hotel_plan.hotel_plan_option
    @hotel_room_settings = @hotel_plan_option.hotel_room_settings.where(hotel_room_id: params[:hotel_room_id])
  end

  def call
    authorize nil, Hotel::Plan::OptionPolicy

    ActiveRecord::Base.transaction do
      @hotel_plan_option.update!(room_ids: update_room_ids)
      @hotel_room_settings.destroy_all
    end
  end

  private

  def update_room_ids
    return unless @hotel_plan_option.room_ids.include?(params[:hotel_room_id].to_s)

    arr_room_ids = []
    @hotel_plan_option.room_ids.each do |item|
      arr_room_ids.push(item)
    end
    arr_room_ids.delete(params[:hotel_room_id].to_s)
    arr_room_ids
  end

  def require_params
    return raise BadRequestError, hotel_room_id: I18n.t('models.can_not_blank') unless params[:hotel_room_id]
  end
end

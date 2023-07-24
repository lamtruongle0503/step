# frozen_string_literal: true

class Api::HotelOperations::RoomOperations::CallendarsOperations::Index < ApplicationOperation
  def initialize(actor, params)
    super
    check_exist_params
    @hotel = Hotel.find(params[:hotel_id])
    @plan = @hotel.hotel_plans.find(params[:plan_id])
    @room = @plan.hotel_rooms.setting_show.find(params[:room_id])
  end

  def call
    date_start = params[:date].to_date.prev_month
    date_end = date_start.since(5.month).end_of_month.to_date
    @plan.hotel_room_settings.month_of_callendar(@room.id, date_start, date_end).order(date: :asc)
  end

  private

  def check_exist_params
    return raise BadRequestError, date: I18n.t('models.can_not_blank') unless params[:date]
  end
end

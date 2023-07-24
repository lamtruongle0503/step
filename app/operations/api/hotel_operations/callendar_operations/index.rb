# frozen_string_literal: true

class Api::HotelOperations::CallendarOperations::Index < ApplicationOperation
  attr_reader :date_start, :date_end

  def initialize(actor, params)
    super
    check_exist_params
    @date_start = params[:date].to_date.prev_month
    @date_end = date_start.since(5.month).end_of_month.to_date
    @hotel = Hotel.find(params[:hotel_id])
    @hotel_plans = @hotel.hotel_plans.setting_show
  end

  def call
    return [] unless @hotel_plans.present?

    plan_ids = @hotel_plans.pluck(:id)
    Hotel::RoomSetting.includes(:hotel_plan)
                      .where(hotel_plan_id: plan_ids, status: Hotel::RoomSetting::OPEN)
                      .where("date BETWEEN '#{date_start}' AND '#{date_end}'")
                      .order(date: :ASC, two_people_fee: :ASC)
                      .uniq(&:date)
  end

  private

  def check_exist_params
    return raise BadRequestError, date: I18n.t('models.can_not_blank') unless params[:date]
  end
end

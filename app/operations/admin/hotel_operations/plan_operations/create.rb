# frozen_string_literal: true

class Admin::HotelOperations::PlanOperations::Create < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
  end

  def call
    authorize nil, Hotel::PlanPolicy

    HotelContracts::PlanContracts::Create.new(plan_params.merge(children_ids: params[:children_ids])).valid!
    ActiveRecord::Base.transaction do
      hotel_plan = @hotel.hotel_plans.create!(plan_params)
      if params[:setting_children] == Hotel::Plan::POSSIBLE && params[:children_ids]
        create_hotel_plan_childrens(hotel_plan.reload)
      end
      upload_image_hotel_plans(hotel_plan.reload) if params[:file]
    end
  end

  private

  def plan_params
    params.permit(:name, :management_name, :type_plan, :rate_type, :setting_show,
                  :day_hidden, :setting_payments, :start_stay_date, :credit_card_transaction_fee,
                  :end_stay_date, :setting_limit, :room_limit, :setting_number_night_stay,
                  :from_night, :to_night, :setting_limit_room, :from_room, :to_room,
                  :is_sale_off, :setting_check_in_out, :check_in, :check_out,
                  :setting_children, :hotel_meal_id, :hotel_cancellation_policy_id,
                  :is_use_coupon, :point_receive, :exp_point_receive, :point_bonus,
                  :exp_point_bonus, :settlement_date, :settlement_time, payments: [],
                  type_meal: [], option_ids: [], setting_sale_off: %i[day percent])
  end

  def create_hotel_plan_childrens(hotel_plan)
    hotel_plan_children = []
    params[:children_ids].each do |child_id|
      hotel_plan_children.push({ hotel_children_info_id: child_id })
    end
    hotel_plan.hotel_plan_childrens.import!(hotel_plan_children)
  end

  def upload_image_hotel_plans(hotel)
    return unless params[:file].is_a? Array

    params[:file].each do |file|
      upload_multiple_file(hotel, file[:url], file[:type], file[:file_type])
    end
  end
end

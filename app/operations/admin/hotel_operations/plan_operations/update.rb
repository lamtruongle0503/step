# frozen_string_literal: true

class Admin::HotelOperations::PlanOperations::Update < ApplicationOperation
  attr_reader :hotel_plan

  def initialize(actor, params)
    super
    @hotel_plan = Hotel::Plan.find(params[:id])
  end

  def call
    authorize nil, Hotel::PlanPolicy

    ActiveRecord::Base.transaction do
      update_hotel_plan
      if params[:setting_children] == Hotel::Plan::POSSIBLE && params[:children_ids]
        update_hotel_plan_childrens
      end
      upload_image_hotel_plans(hotel_plan) if params[:file]
    end
  end

  private

  def update_hotel_plan
    HotelContracts::PlanContracts::Update.new(plan_params.merge(children_ids: params[:children_ids])).valid!
    hotel_plan.update!(plan_params)
  end

  def plan_params
    params.permit(:name, :management_name, :type_plan, :rate_type, :setting_show,
                  :day_hidden, :payments, :setting_payments, :start_stay_date, :credit_card_transaction_fee,
                  :end_stay_date, :setting_limit, :room_limit, :setting_number_night_stay,
                  :from_night, :to_night, :setting_limit_room, :from_room, :to_room,
                  :is_sale_off, :setting_check_in_out, :check_in, :check_out,
                  :setting_children, :hotel_meal_id, :hotel_option_id, :hotel_cancellation_policy_id,
                  :is_use_coupon, :point_receive, :exp_point_receive, :point_bonus, :exp_point_bonus,
                  :settlement_date, :settlement_time, type_meal: [], option_ids: [], payments: [],
                  setting_sale_off: %i[day percent])
  end

  def update_hotel_plan_childrens
    hotel_plan.hotel_plan_childrens&.destroy_all
    hotel_plan_children = []
    params[:children_ids].each do |child_id|
      hotel_plan_children.push({ hotel_children_info_id: child_id })
    end
    hotel_plan.hotel_plan_childrens.import!(hotel_plan_children)
  end

  def upload_image_hotel_plans(hotel_plan)
    return unless params[:file].is_a? Array

    params[:file].each do |file|
      upload_multiple_file(hotel_plan, file[:url], file[:type], file[:file_type])
    end
  end
end

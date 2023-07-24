# frozen_string_literal: true

class Api::HotelOperations::PlanOperations::Index < ApplicationOperation
  def initialize(actor, params)
    super
    require_params
    @hotel = Hotel.find(params[:hotel_id])
    @remain_room = params[:q][:hotel_room_settings_remain_room_gteq].to_i
    @in_stay = params[:p][:date_check_in].to_date
    @to_night = params[:p][:to_night].to_i
    @last_stay = @in_stay + @to_night
  end

  def call
    @q = @hotel.hotel_plans.setting_show.ransack(set_dafault_search_params)
    @hotel_plan = @q.result(distinct: true).includes([hotel_meal: :assets])
                    .search_in_number_night(params[:p][:to_night])
    @result = @hotel_plan.select do |plan|
      check_remain_room(plan, @remain_room, @in_stay, @last_stay)
    end
    filter_type_childrens(@result)
  end

  private

  def require_params
    unless params[:p][:date_check_in]
      return raise BadRequestError,
                   date_check_in: I18n.t('models.can_not_blank')
    end
    unless params[:p][:to_night]
      return raise BadRequestError,
                   to_night: I18n.t('models.can_not_blank')
    end
    return if params[:p][:total_person]

    raise BadRequestError, total_person: I18n.t('models.can_not_blank')
  end

  def set_dafault_search_params
    params[:q] ||= {}
    if params[:q][:setting_children_eq].to_i.zero? && params[:q][:hotel_rooms_number_children_gteq].present?
      params[:q].delete(:hotel_rooms_number_children_gteq)
      params[:q].merge!(hotel_rooms_number_children_eq: 0)
    end
    params[:q].delete(:hotel_room_settings_remain_room_gteq)
  end

  def filter_type_childrens(plans)
    return plans if !params[:children_infos].present? || params[:q][:setting_children_eq].to_i.zero?

    arr_param_children = params[:children_infos].split(',')
    plan_filered = plans.map do |obj|
      children_code = obj.children_infos.pluck(:code)
      next if (arr_param_children - children_code).size.positive?

      obj
    end

    plan_filered.compact
  end

  def check_remain_room(plan, remain_room, in_stay, last_stay)
    return true if plan.type_plan == Hotel::Plan::REQUEST

    plan.hotel_room_settings.where(date: in_stay...last_stay).each do |hotel_room_setting|
      return true if hotel_room_setting.remain_room >= remain_room
    end
    false
  end
end

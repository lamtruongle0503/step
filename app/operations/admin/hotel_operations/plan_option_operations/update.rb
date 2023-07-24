# frozen_string_literal: true

class Admin::HotelOperations::PlanOptionOperations::Update < ApplicationOperation
  attr_reader :hotel, :hotel_plan, :hotel_plan_option, :hotel_room

  def initialize(actor, params)
    super
    require_params
    @hotel = Hotel.find(params[:hotel_id])
    @hotel_plan = hotel.hotel_plans.find(params[:plan_id])
    @hotel_plan_option = hotel_plan.hotel_plan_option
  end

  def call
    authorize nil, Hotel::Plan::OptionPolicy

    ActiveRecord::Base.transaction do
      update_hotel_plan_option
      update_hotel_room_setting if params[:room_settings]
    end
  end

  private

  def update_hotel_plan_option
    HotelContracts::PlanOptionContracts::Update.new(plan_options_params).valid!
    hotel_plan_option.update!(plan_options_params)
  end

  def update_hotel_room_setting # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    room_settings = []
    room_setting_params[:room_settings].each do |room_setting_params|
      if room_setting_params[:id].present?
        setting = Hotel::RoomSetting.find(room_setting_params[:id])
        setting.update!(room_setting_params)
      else
        HotelContracts::RoomSettingContracts::Create.new(
          room_setting_params.merge(hotel_plan_id:   hotel_plan.id,
                                    hotel_plan:      hotel_plan,
                                    start_stay_date: hotel_plan.start_stay_date,
                                    end_stay_date:   hotel_plan.end_stay_date),
        ).valid!

        room_settings.push({
                             hotel_plan_id:      hotel_plan.id,
                             hotel_room_id:      params[:hotel_room_id],
                             date:               room_setting_params[:date],
                             remain_room:        room_setting_params[:remain_room],
                             reservation_number: room_setting_params[:reservation_number],
                             one_person_fee:     room_setting_params[:one_person_fee],
                             two_people_fee:     room_setting_params[:two_people_fee],
                             three_people_fee:   room_setting_params[:three_people_fee],
                             four_people_fee:    room_setting_params[:four_people_fee],
                             five_people_fee:    room_setting_params[:five_people_fee],
                             six_person_fee:     room_setting_params[:six_person_fee],
                             seven_person_fee:   room_setting_params[:seven_person_fee],
                             eight_person_fee:   room_setting_params[:eight_person_fee],
                             nine_person_fee:    room_setting_params[:nine_person_fee],
                             ten_person_fee:     room_setting_params[:ten_person_fee],
                             status:             room_setting_params[:status],
                           })
      end
    end
    hotel_plan_option.hotel_room_settings.import!(room_settings)
  end

  def plan_options_params
    params.permit(:hotel_meal_id, :start_date_stay, :end_date_stay, room_ids: [])
  end

  def room_setting_params
    unless params[:room_settings]
      raise BadRequestError,
            room_settings: I18n.t('models.can_not_blank')
    end

    params.permit(room_settings: %i[remain_room date hotel_room_id
                                    reservation_number one_person_fee two_people_fee
                                    three_people_fee four_people_fee five_people_fee id
                                    six_person_fee seven_person_fee eight_person_fee
                                    nine_person_fee ten_person_fee status])
  end

  def require_params
    return raise BadRequestError, hotel_room_id: I18n.t('models.can_not_blank') unless params[:hotel_room_id]
  end
end

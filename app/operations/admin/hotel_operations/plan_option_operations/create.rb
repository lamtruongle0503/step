# frozen_string_literal: true

class Admin::HotelOperations::PlanOptionOperations::Create < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
    @hotel_plan = @hotel.hotel_plans.find(params[:plan_id])
    @hotel_plan_option = @hotel_plan.hotel_plan_option
  end

  def call
    authorize nil, Hotel::Plan::OptionPolicy

    ActiveRecord::Base.transaction do
      if @hotel_plan_option.present?
        @hotel_plan_option.update!(plan_options_params)
        create_hotel_room_setting(@hotel_plan_option.reload)
      else
        HotelContracts::PlanOptionContracts::Create.new(
          plan_options_params.merge(hotel_plan_id: @hotel_plan.id),
        ).valid!
        plan_option = Hotel::PlanOption.create!(plan_options_params.merge(hotel_plan_id: @hotel_plan.id))
        create_hotel_room_setting(plan_option.reload)
      end
    end
  end

  private

  def create_hotel_room_setting(plan_option)
    room_settings = []
    room_setting_params[:room_settings].each do |room_setting_params|
      HotelContracts::RoomSettingContracts::Create.new(
        room_setting_params.merge(hotel_plan_id:   @hotel_plan.id,
                                  hotel_plan:      @hotel_plan,
                                  start_stay_date: @hotel_plan.start_stay_date,
                                  end_stay_date:   @hotel_plan.end_stay_date),
      ).valid!
      room_settings.push({
                           hotel_plan_id:      @hotel_plan.id,
                           hotel_room_id:      room_setting_params[:hotel_room_id],
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
    plan_option.hotel_room_settings.import!(room_settings)
  end

  def plan_options_params
    params.permit(:hotel_meal_id, :start_date_stay, :end_date_stay, room_ids: [])
  end

  def room_setting_params
    unless params[:room_settings]
      raise BadRequestError,
            room_settings: I18n.t('models.can_not_blank')
    end

    params.permit(room_settings: %i[hotel_plan_id hotel_room_id remain_room date
                                    reservation_number one_person_fee two_people_fee
                                    three_people_fee four_people_fee five_people_fee
                                    six_person_fee seven_person_fee eight_person_fee
                                    nine_person_fee ten_person_fee status])
  end
end

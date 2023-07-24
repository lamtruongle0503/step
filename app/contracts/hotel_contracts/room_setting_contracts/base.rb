# frozen_string_literal: true

class HotelContracts::RoomSettingContracts::Base < ApplicationContract
  attribute :hotel_room_id, Integer
  attribute :date, Date
  attribute :remain_room, Integer
  attribute :reservation_number, Integer
  attribute :one_person_fee, Integer
  attribute :two_people_fee, Integer
  attribute :three_people_fee, Integer
  attribute :four_people_fee, Integer
  attribute :five_people_fee, Integer
  attribute :six_person_fee, Integer
  attribute :seven_person_fee, Integer
  attribute :eight_person_fee, Integer
  attribute :nine_person_fee, Integer
  attribute :ten_person_fee, Integer
  attribute :start_stay_date, Date
  attribute :end_stay_date, Date
  attribute :status, Integer
  attribute :hotel_plan_id, Integer
  attribute :hotel_plan, Object

  validates :hotel_room_id, existence: Hotel::Room.name
  validate :check_setting_room_plan
  validates :date, presence:   true,
                   uniqueness: { model: Hotel::RoomSetting, scope: %i[hotel_plan_id hotel_room_id] }
  validate :check_date_plan
  with_options numericality: { only_integer: true }, length: { maximum: 15 } do
    validates :remain_room, if: -> { remain_room }
    validates :reservation_number, if: -> { reservation_number }
    validates :one_person_fee, if: -> { one_person_fee }
    validates :two_people_fee, if: -> { two_people_fee }
    validates :three_people_fee, if: -> { three_people_fee }
    validates :four_people_fee, if: -> { four_people_fee }
    validates :five_people_fee, if: -> { five_people_fee }
    validates :six_person_fee, if: -> { six_person_fee }
    validates :seven_person_fee, if: -> { seven_person_fee }
    validates :eight_person_fee, if: -> { eight_person_fee }
    validates :nine_person_fee, if: -> { nine_person_fee }
    validates :ten_person_fee, if: -> { ten_person_fee }
  end
  validates :status, inclusion: { in: Hotel::RoomSetting.statuses }

  def check_setting_room_plan
    return if hotel_plan.setting_limit_room == Hotel::Plan::UNLIMITED_ROOM
    return if hotel_plan.type_plan == Hotel::Plan::REQUEST
    return if remain_room.between?(hotel_plan.from_room, hotel_plan.to_room)

    errors.add :remain_room, I18n.t('hotels.rooms.remain_room_not_in_range')
  end

  def check_date_plan
    return if date.between?(start_stay_date, end_stay_date)

    errors.add :date, I18n.t('hotels.rooms.not_on_the_plan_date')
  end
end

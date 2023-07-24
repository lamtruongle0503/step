# frozen_string_literal: true

class HotelContracts::RoomContracts::Base < ApplicationContract
  attribute :capacity, Integer
  attribute :description, String
  attribute :floor_plan, String
  attribute :is_show, Boolean
  attribute :is_smoking, Integer
  attribute :management_name, String
  attribute :name, String
  attribute :room_type, String
  attribute :setting_date, Date
  attribute :square_meter_max, Float
  attribute :square_meter_min, Float
  attribute :total_floor_max, Integer
  attribute :total_floor_min, Integer
  attribute :floor_type, Integer
  attribute :created_at, DateTime
  attribute :updated_at, DateTime
  attribute :number_children, Integer
  attribute :hotel_allow_children, Integer

  validates :capacity,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  with_options numericality: { greater_than_or_equal_to: 0 }, length: { maximum: 15 } do
    validates :square_meter_max, if: -> { square_meter_max }
    validates :total_floor_max, if: -> { total_floor_max }
    validates :square_meter_min,
              numericality: { less_than_or_equal_to: :square_meter_max }
    validates :total_floor_min,
              numericality: { only_integer: true, greater_than_or_equal_to: 0,
                              less_than_or_equal_to: :total_floor_max }
  end
  validates :floor_type, inclusion: { in: Hotel::Room.floor_types }
  validates :is_smoking, inclusion: { in: Hotel::Room.is_smokings }
  validates :room_type, inclusion: { in: Hotel::Room.room_types }
  validate :validate_setting_number_children

  def validate_setting_number_children
    return if hotel_allow_children == Hotel::CHILD_AVAILABLE || number_children.zero?

    errors.add :number_children, I18n.t('hotels.rooms.child_no_available')
  end
end

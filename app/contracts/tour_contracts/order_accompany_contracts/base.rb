# frozen_string_literal: true

class TourContracts::OrderAccompanyContracts::Base < ApplicationContract
  attribute :address1,                    String
  attribute :address2,                    String
  attribute :birth_day,                   Date
  attribute :departure_start_location,    String
  attribute :depature_time,               String
  attribute :email,                       String
  attribute :first_name,                  String
  attribute :first_name_kana,             String
  attribute :full_name,                   String
  attribute :furigana,                    String
  attribute :gender,                      Integer
  attribute :is_owner,                    Boolean
  attribute :is_save,                     Boolean
  attribute :is_user,                     Boolean
  attribute :last_name,                   String
  attribute :last_name_kana,              String
  attribute :phone_number,                String
  attribute :pickup_location,             Integer
  attribute :post_code,                   String
  attribute :room,                        String
  attribute :selected_seat,               String
  attribute :telephone,                   String
  attribute :tour_option_id,              Integer
  attribute :tour_order_id,               Integer
  attribute :tour_special_food_id,        Integer
  attribute :tour_bus_info,               Tour::BusInfo
  attribute :price_food,                  Hash
  attribute :user,                        User
  validates :age, numericality: { other_than: 0 }
  validates :birth_day, presence: true, if: -> { age.positive? }

  def age
    cal_age(birth_day)
  end

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/.freeze

  validates :email, format: { with: EMAIL_REGEX }, if: -> { email.present? }
  validates :telephone, format: { with: PHONE_REGEX }, if: -> { telephone.present? }
  validates :gender, inclusion: { in: Tour::OrderAccompany.genders.keys }
  validates :phone_number, presence: true, format: { with: PHONE_REGEX }, if: -> { is_owner.present? }
  validates :address1, :address2, presence: true, if: -> { is_owner.present? }
  validates :post_code, presence: true, if: -> { is_owner.present? }
  validate  :check_seat_bus, if: -> { selected_seat.present? }

  with_options presence: true do
    validates :first_name
    validates :last_name
    validates :first_name_kana, unless: -> { (is_owner.present? || is_user.present?) && user.blank? }
    validates :last_name_kana, unless: -> { (is_owner.present? || is_user.present?) && user.blank? }
  end

  def check_seat_bus
    seats_hide = find_seat_hide(tour_bus_info.seats_map)
    return unless seats_hide.include?(selected_seat)

    raise BadRequestError,
          tour_bus_info: I18n.t('order_tours.tours.select_booked')
  end

  def find_seat_hide(seats_map)
    seats_hide = []
    seats_map.each do |seat_map|
      seat_map.each do |seat|
        seats_hide << seat['name'] if seat['type'] == Tour::BusInfo::HIDE
      end
    end
    seats_hide
  end
end

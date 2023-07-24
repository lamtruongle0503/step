# == Schema Information
#
# Table name: tour_orders
#
#  id                                 :bigint           not null, primary key
#  cancellation_fee                   :float
#  cancellation_free                  :boolean          default(FALSE)
#  concentrate_time                   :string
#  coupon_discount                    :float
#  date_of_cancellation               :date
#  date_of_cancellation_fee           :date
#  departure_date                     :date
#  departure_start_location           :string
#  depature_time                      :string
#  discount_amount                    :integer
#  estimate_payment_amount            :float
#  estimate_payment_confirmation_date :date
#  initial_price                      :float            default(0.0)
#  invoice_desc                       :string
#  is_cancellation_free               :boolean          default(FALSE)
#  is_seats_bus_free                  :integer          default("no_free")
#  memo                               :string
#  number_people                      :integer
#  order_no                           :string
#  payment_confirmation_date          :date
#  payment_method                     :integer          default("credit_card")
#  payment_note                       :string
#  payment_status                     :integer
#  price_refund                       :float
#  price_seat                         :jsonb
#  received_bonus_point               :integer
#  received_point                     :integer
#  refund_comfirm_date                :datetime
#  room                               :jsonb
#  seat_selection                     :string
#  status                             :integer          default("confirm")
#  total                              :float            default(0.0)
#  total_price_special_food           :float
#  total_price_stay_departure         :float
#  total_tour                         :float
#  total_tour_bus_seat_map            :float
#  total_tour_option                  :float
#  used_points                        :integer
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  coupon_id                          :integer
#  purchased_id                       :string
#  tour_bus_info_id                   :bigint           not null
#  tour_id                            :bigint           not null
#  tour_stay_departure_id             :bigint
#  user_id                            :bigint
#
# Indexes
#
#  index_tour_orders_on_tour_bus_info_id        (tour_bus_info_id)
#  index_tour_orders_on_tour_id                 (tour_id)
#  index_tour_orders_on_tour_stay_departure_id  (tour_stay_departure_id)
#  index_tour_orders_on_user_id                 (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (tour_bus_info_id => tour_bus_infos.id)
#  fk_rails_...  (tour_id => tours.id)
#  fk_rails_...  (user_id => users.id)
#
class Tour::Order < ApplicationRecord
  belongs_to :tour_bus_info, class_name: 'Tour::BusInfo'
  belongs_to :tour, class_name: 'Tour'
  belongs_to :user, foreign_key: :user_id, class_name: 'User', optional: true
  has_many :tour_order_accompanies, class_name: 'Tour::OrderAccompany', foreign_key: :tour_order_id,
dependent: :destroy
  has_one :tour_order_log, class_name: 'Tour::OrderLog', dependent: :destroy, foreign_key: :tour_order_id
  has_one :point_use, class_name: PointUsage.name, as: :module, dependent: :destroy

  CONFIRM                   = 'confirm'.freeze
  BOOKED                    = 'booked'.freeze
  DONE                      = 'done'.freeze
  CANCEL                    = 'cancel'.freeze
  CREDIT_CARD               = 'credit_card'.freeze
  BANK_TRANSFER             = 'bank_transfer'.freeze
  CONVENIENCE_STORE_PAYMENT = 'convenience_store_payment'.freeze
  SAME_DAY_COLLECTION       = 'same_day_collection'.freeze
  DIRECT_PAYMENT            = 'direct_payment'.freeze
  PENDING                   = 'pending'.freeze
  SUCCEEDED                 = 'succeeded'.freeze
  FAILED                    = 'failed'.freeze
  REFUNED                   = 'refunded'.freeze
  FREE                      = 'free'.freeze
  NO_FREE                   = 'no_free'.freeze
  FULL_PLACE                = 'full_place'.freeze
  CXL_WAITING               = 'cxl_waiting'.freeze

  enum payment_status: { pending: 0, succeeded: 1, failed: 2, refunded: 3 }
  enum status: { confirm: 0, booked: 1, done: 2, cancel: 3, full_place: 4, cxl_waiting: 5 }
  enum payment_method: { credit_card: 0, bank_transfer: 1, convenience_store_payment: 2,
same_day_collection: 3, direct_payment: 4 }
  enum is_seats_bus_free: { no_free: 0, free: 1 }

  scope :find_tour_order_by_tour_id, ->(id) { where(tour_id: id) }

  scope :by_tour_order_after_ten_days, lambda {
    joins(:tour_bus_info).where('tour_bus_infos.departure_date <= ?', Date.current - 10)
  }
  scope :by_tour_order_booked, lambda {
    where(status:         Tour::Order.statuses[Tour::Order::BOOKED],
          payment_status: Tour::Order.payment_statuses[Tour::Order::SUCCEEDED])
  }

  scope :by_status_full_place, -> { where(status: Tour::Order.statuses[Tour::Order::FULL_PLACE]) }
  scope :by_status_cancel, -> { where(status: Tour::Order.statuses[Tour::Order::CANCEL]) }
  scope :by_status_cxl_waiting, -> { where(status: Tour::Order.statuses[Tour::Order::CXL_WAITING]) }

  scope :by_status_not_in_cancel_and_special, lambda {
    where.not(status: [
                Tour::Order::CANCEL,
                Tour::Order::FULL_PLACE,
                Tour::Order::CXL_WAITING,
              ])
  }

  def mail_amount_room # rubocop:disable Metrics/PerceivedComplexity
    message = []
    if room['one_person_fee'].present? && room['one_person_fee'].to_i != 0
      message.push("1名1室：#{room['one_person_fee']}")
    end
    if room['two_person_fee'].present? && room['two_person_fee'].to_i != 0
      message.push("2名1室：#{room['two_person_fee']}")
    end
    if room['three_person_fee'].present? && room['three_person_fee'].to_i != 0
      message.push("3名1室：#{room['three_person_fee']}")
    end
    if room['four_person_fee'].present? && room['four_person_fee'].to_i != 0
      message.push("4名1室：#{room['four_person_fee']}")
    end
    message.join(', ').gsub(', ', '、')
  end

  def mail_price_room # rubocop:disable Metrics/PerceivedComplexity, Metrics/AbcSize
    message = []
    if tour.type_locate == Tour::STAY
      stay_departure = tour_order_log.tour_stay_departures
      if room['one_person_fee'].present? && room['one_person_fee'].to_i != 0
        message.push("#{stay_departure['one_person_fee'].to_i}円×#{room['one_person_fee']}名")
      end
      if room['two_person_fee'].present? && room['two_person_fee'].to_i != 0
        message.push("#{stay_departure['two_person_fee'].to_i}円×#{room['two_person_fee']}名")
      end
      if room['three_person_fee'].present? && room['three_person_fee'].to_i != 0
        message.push("#{stay_departure['three_person_fee'].to_i}円×#{room['three_person_fee']}名")
      end
      if room['four_person_fee'].present? && room['four_person_fee'].to_i != 0
        message.push("#{stay_departure['four_person_fee'].to_i}円×#{room['four_person_fee']}名")
      end
    end
    message.join(', ').gsub(', ', '、')
  end

  def mail_seat_price # rubocop:disable Metrics/PerceivedComplexity
    message = []
    tour_seat_map = tour_order_log.amount_tour_bus_seat_map
    if tour_seat_map['row1'].present? && tour_seat_map['row1'].to_i != 0
      message.push("#{tour_seat_map['first_row_seat_price'].to_i}円×#{tour_seat_map['row1']}名")
    end
    if tour_seat_map['row2'].present? && tour_seat_map['row2'].to_i != 0
      message.push("#{tour_seat_map['two_rows_seat_price'].to_i}円×#{tour_seat_map['row2']}名")
    end
    if tour_seat_map['row3'].present? && tour_seat_map['row3'].to_i != 0
      message.push("#{tour_seat_map['two_rows_seat_price'].to_i}円×#{tour_seat_map['row3']}名")
    end
    if tour_seat_map['special_row'].present? && tour_seat_map['special_row'].to_i != 0
      message.push("#{tour_seat_map['regular_seat_price'].to_i}円×#{tour_seat_map['special_row']}名")
    end
    message.join(', ').gsub(', ', '、')
  end
end

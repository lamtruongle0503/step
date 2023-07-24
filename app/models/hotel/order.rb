# == Schema Information
#
# Table name: hotel_orders
#
#  id                        :bigint           not null, primary key
#  adult_total               :integer
#  cancellation_fee          :integer
#  cancellation_free         :boolean
#  cancellation_other_reason :string
#  cancellation_type         :integer
#  check_in                  :string
#  check_out                 :string
#  childrens                 :jsonb
#  comments                  :string
#  date_cancel               :date
#  deleted_at                :datetime
#  discount_amount           :integer
#  manifest                  :string
#  number_night              :integer
#  number_of_rooms           :integer
#  option_ids                :string           default([]), is an Array
#  order_no                  :string
#  payment_method            :integer
#  payment_note              :string
#  payment_status            :integer
#  people_per_room           :integer
#  people_statistic          :string
#  person_total              :integer
#  phone_reciprocal_time     :string
#  price_children            :integer          default(0)
#  price_option              :integer          default(0)
#  price_room                :integer          default(0)
#  price_sale_off_stay_night :integer          default(0)
#  registrar_name            :string
#  registration_pattern      :string
#  reservation_amount        :integer
#  status                    :integer          default("requesting")
#  tax_service               :integer
#  time_estimate             :string
#  total                     :integer
#  total_peoples             :integer
#  total_room                :integer          default(1)
#  used_points               :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  coupon_id                 :bigint
#  hotel_id                  :bigint
#  hotel_order_accompany_id  :bigint
#  hotel_plan_id             :bigint
#  hotel_room_id             :bigint
#  purchased_id              :string
#  user_contact_id           :bigint
#  user_id                   :bigint
#
# Indexes
#
#  index_hotel_orders_on_coupon_id                 (coupon_id)
#  index_hotel_orders_on_hotel_id                  (hotel_id)
#  index_hotel_orders_on_hotel_order_accompany_id  (hotel_order_accompany_id)
#  index_hotel_orders_on_hotel_plan_id             (hotel_plan_id)
#  index_hotel_orders_on_hotel_room_id             (hotel_room_id)
#  index_hotel_orders_on_user_contact_id           (user_contact_id)
#  index_hotel_orders_on_user_id                   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (coupon_id => coupons.id)
#  fk_rails_...  (hotel_id => hotels.id)
#  fk_rails_...  (hotel_order_accompany_id => hotel_order_accompanies.id)
#  fk_rails_...  (hotel_plan_id => hotel_plans.id)
#  fk_rails_...  (user_id => users.id)
#
class Hotel::Order < ApplicationRecord
  acts_as_paranoid

  belongs_to :hotel, foreign_key: :hotel_id
  belongs_to :user, foreign_key: :user_id, optional: true
  belongs_to :user_contact, foreign_key: :user_contact_id, optional: true
  belongs_to :hotel_order_accompany, foreign_key: :hotel_order_accompany_id,
                                     class_name:  'Hotel::OrderAccompany'
  belongs_to :hotel_room, foreign_key: :hotel_room_id, class_name: 'Hotel::Room'
  belongs_to :hotel_plan, foreign_key: :hotel_plan_id, class_name: 'Hotel::Plan'
  belongs_to :coupon, foreign_key: :coupon_id, optional: true
  has_one :hotel_order_log, class_name: 'Hotel::OrderLog', foreign_key: :hotel_order_id
  has_many :point_usages, foreign_key: :module_id, dependent: :destroy

  # status order
  REQUESTING = 'requesting'.freeze
  CONFIRMING_CUSTOMER = 'confirming_customer'.freeze
  RESERVE = 'reserve'.freeze
  STAYED = 'stayed'.freeze
  CANCEL_ALREADY = 'cancel_already'.freeze

  # Tax service
  CONSUMPTION_TAX_AND_SERVICE_FEE = 'consumption_tax_and_service_fee'.freeze
  CONSUMPTION_TAX_AND_NO_SERVICE_FEE = 'consumption_tax_and_no_service_fee'.freeze
  NO_CONSUMPTION_TAX_AND_SERVICE_FEE = 'no_consumption_tax_and_service_fee'.freeze

  # cancellation_type
  ACCOMMODATION_CANCELED = 'accommodation_canceled'.freeze
  DESTINATION_CHANGED = 'destination_changed'.freeze
  CHANGE_OF_ACCOMMODATION_SCHEDULE = 'change_of_accommodation_schedule'.freeze
  CHANGE_ACCOMMODATION_FACILITIES = 'change_accommodation_facilities'.freeze
  OTHER = 'other'.freeze

  # payment_status
  PENDING                   = 'pending'.freeze
  SUCCEEDED                 = 'succeeded'.freeze
  FAILED                    = 'failed'.freeze
  REFUNED                   = 'refunded'.freeze

  # payment_method
  CREDIT_CARD = 'credit_card'.freeze
  ON_SPOT = 'on_spot'.freeze

  enum status: { requesting: 0, confirming_customer: 1, reserve: 2, stayed: 3, cancel_already: 4 }
  enum tax_service: { consumption_tax_and_service_fee: 0, consumption_tax_and_no_service_fee: 1,
    no_consumption_tax_and_service_fee: 2 }
  enum cancellation_type: { accommodation_canceled: 1, destination_changed: 2,
    change_of_accommodation_schedule: 3, change_accommodation_facilities: 4, other: 5 }
  enum payment_status: { pending: 0, succeeded: 1, failed: 2, refunded: 3 }
  enum payment_method: { credit_card: 0, on_spot: 1 }

  scope :order_type_payment, lambda { |type_plan, order_status, payment_method, payment_status|
    joins(:hotel_plan)
      .where(<<-SQL.strip_heredoc)
        hotel_plans.type_plan = #{type_plan}
      AND hotel_orders.status != #{order_status}
      AND hotel_orders.payment_method = #{payment_method}
      AND hotel_orders.payment_status = #{payment_status}
    SQL
  }

  scope :cancel_order_type_payment, lambda { |type_plan, order_status, payment_method|
    joins(:hotel_plan)
      .where(<<-SQL.strip_heredoc)
        hotel_plans.type_plan = #{type_plan}
      AND hotel_orders.status = #{order_status}
      AND hotel_orders.payment_method = #{payment_method}
    SQL
  }

  ransacker :order_in_month do
    Arel.sql('EXTRACT(MONTH FROM hotel_orders.created_at)')
  end

  ransacker :order_in_year do
    Arel.sql('EXTRACT(YEAR FROM hotel_orders.created_at)')
  end
end

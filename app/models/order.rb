# == Schema Information
#
# Table name: orders
#
#  id                   :bigint           not null, primary key
#  checkout_date        :date
#  code                 :string
#  coupon_amount        :float
#  deleted_at           :datetime
#  delivered_date       :date
#  delivery_amount      :float
#  delivery_charges_fee :float
#  delivery_code        :string
#  delivery_free_amount :integer
#  delivery_status      :integer
#  order_status         :integer
#  payment_status       :integer
#  purchased_amount     :float
#  received_bonus_point :float
#  received_point       :float
#  used_point           :float
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  agency_id            :integer
#  coupon_id            :integer
#  delivery_id          :integer
#  payment_id           :integer
#  purchased_id         :string
#  user_id              :bigint
#
# Indexes
#
#  index_orders_on_code     (code)
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :coupon, optional: true

  has_many :order_products, dependent: :destroy
  has_many :product_sizes, through: :order_products
  has_many :products, through: :product_sizes
  has_one :order_info, dependent: :destroy
  has_one :coupon_order, dependent: :destroy
  has_one :coupon, through: :coupon_order
  has_one :point_use, -> { used_points }, class_name: PointUsage.name, as: :module, dependent: :destroy
  has_many :point_usages, class_name: PointUsage.name, dependent: :destroy, as: :module
  has_many :area_settings, through: :product
  belongs_to :agency
  belongs_to :payment, optional: true
  belongs_to :delivery, optional: true

  accepts_nested_attributes_for :order_products, :order_info

  # Status Order
  WAITING    = 'waiting'.freeze
  INPROGRESS = 'inprogress'.freeze
  CONFIRM    = 'confirm'.freeze
  DELIVERY   = 'delivery'.freeze
  DONE       = 'done'.freeze
  CANCEL     = 'cancel'.freeze
  DRAFT      = 'draft'.freeze

  # Status charge STRIPE SERVICE
  PENDING          = 'pending'.freeze
  SUCCEEDED        = 'succeeded'.freeze
  FAILED           = 'failed'.freeze
  REFUNED          = 'refunded'.freeze
  CASH_ON_DELIVERY = 'cash_on_delivery'.freeze

  # Status Delivery
  DELIVERIED   = 'deliveried'.freeze
  PREPARING    = 'preparing'.freeze
  OUT_OF_STOCK = 'out_of_stock'.freeze
  IN_DELIVERY  = 'in_delivery'.freeze
  NOT_DELIVERY = 'not_delivery'.freeze

  # payment type
  CREDIT_CARD = 'credit_card'.freeze
  ON_DELIVERY = 'on_delivery'.freeze
  BANK_TRANSFER = 'bank_transfer'.freeze
  CONVENIENCE_STORE = 'convenience_store'.freeze

  STATUS = [PENDING, INPROGRESS, CONFIRM, DELIVERY, DONE, CANCEL].freeze
  PAYMENT_STATUS = [PENDING, SUCCEEDED, FAILED, CASH_ON_DELIVERY].freeze

  enum order_status: { waiting: 0, inprogress: 1, confirm: 2, delivery: 3, done: 4, cancel: 5, draft: 6 }
  enum payment_status: { pending: 0, succeeded: 1, failed: 2, refunded: 3, cash_on_delivery: 4 }
  enum delivery_status: { deliveried: 0, not_delivery: 1, preparing: 3, out_of_stock: 4, in_delivery: 5 }
  enum payment_type: { credit_card: 1, convenience_store: 2, on_delivery: 3, bank_transfer: 4 }

  scope :order_waiting_with_agency, lambda { |agency_id|
                                      where(
                                        order_status: WAITING,
                                        agency_id:    agency_id,
                                      )
                                    }

  scope :without_awaiting, lambda {
    where.not(order_status: [WAITING, DRAFT])
  }

  ransacker :checkout_date, type: :date do
    Arel.sql 'DATE(orders.checkout_date)'
  end
end

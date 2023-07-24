# == Schema Information
#
# Table name: order_products
#
#  id               :bigint           not null, primary key
#  color            :string
#  deleted_at       :datetime
#  discount         :float            default(100.0)
#  number           :integer
#  price            :float
#  purchased_amount :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  order_id         :bigint
#  product_id       :bigint
#  product_size_id  :integer
#
# Indexes
#
#  index_order_products_on_order_id    (order_id)
#  index_order_products_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_id => products.id)
#
class OrderProduct < ApplicationRecord
  acts_as_paranoid

  belongs_to :order
  belongs_to :product_size, -> { with_deleted }
  has_one :product, through: :product_size
  has_one :order_log, class_name: OrderLog.name, dependent: :destroy, foreign_key: :order_products_id

  before_create do |record|
    record.price = record.product_size.price
  end

  scope :by_color, lambda { |order_id, color|
    return unless color

    where(order_id: order_id, color: color)
  }
end

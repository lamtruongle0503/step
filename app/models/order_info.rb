# == Schema Information
#
# Table name: order_infos
#
#  id                  :bigint           not null, primary key
#  buy_name            :string
#  content             :string
#  deleted_at          :datetime
#  delivery_date       :date
#  delivery_end_time   :time
#  delivery_start_time :time
#  email_receiption    :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  address_id          :bigint
#  order_id            :bigint
#
# Indexes
#
#  index_order_infos_on_address_id  (address_id)
#  index_order_infos_on_order_id    (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
class OrderInfo < ApplicationRecord
  acts_as_paranoid

  belongs_to :order
  belongs_to :address, optional: true
end

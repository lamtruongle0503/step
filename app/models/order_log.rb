# == Schema Information
#
# Table name: order_logs
#
#  id                :bigint           not null, primary key
#  product           :jsonb
#  product_size      :jsonb
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  order_products_id :bigint           not null
#
# Indexes
#
#  index_order_logs_on_order_products_id  (order_products_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_products_id => order_products.id)
#
class OrderLog < ApplicationRecord
  belongs_to :order_product, class_name: OrderProduct.name, foreign_key: :order_products_id
end

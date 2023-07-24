# == Schema Information
#
# Table name: delivery_time_settings
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  end_time   :time
#  start_time :time
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint
#
# Indexes
#
#  index_delivery_time_settings_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class DeliveryTimeSetting < ApplicationRecord
  acts_as_paranoid

  belongs_to :product
end

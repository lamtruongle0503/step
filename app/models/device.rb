# == Schema Information
#
# Table name: devices
#
#  id           :bigint           not null, primary key
#  deleted_at   :datetime
#  device_token :string
#  os           :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Indexes
#
#  index_devices_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Device < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
end

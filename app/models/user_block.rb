# == Schema Information
#
# Table name: user_blocks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  blocked_id :integer          not null
#  blocker_id :integer          not null
#
class UserBlock < ApplicationRecord
  belongs_to :user_blocker, class_name: User.name, foreign_key: :blocked_id
  belongs_to :user_blocked, class_name: User.name, foreign_key: :blocker_id

  scope :user_blocked, ->(user_id) { where(blocked_id: user_id) }
end

# == Schema Information
#
# Table name: follows
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer          not null
#  follower_id :integer          not null
#
class Follow < ApplicationRecord
  belongs_to :user_follower, class_name: User.name, foreign_key: :followed_id
  belongs_to :user_followed, class_name: User.name, foreign_key: :follower_id

  scope :user_followed, ->(user_id) { where(followed_id: user_id) }
end

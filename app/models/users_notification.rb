# == Schema Information
#
# Table name: users_notifications
#
#  id              :bigint           not null, primary key
#  deleted_at      :datetime
#  is_read         :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notification_id :bigint
#  user_id         :bigint
#
# Indexes
#
#  index_users_notifications_on_is_read          (is_read)
#  index_users_notifications_on_notification_id  (notification_id)
#  index_users_notifications_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (notification_id => notifications.id)
#  fk_rails_...  (user_id => users.id)
#
class UsersNotification < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :notification
end

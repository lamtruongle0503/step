# == Schema Information
#
# Table name: notifications_prefectures
#
#  id              :bigint           not null, primary key
#  deleted_at      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notification_id :bigint           not null
#  prefecture_id   :bigint           not null
#
# Indexes
#
#  index_notifications_prefectures_on_notification_id  (notification_id)
#  index_notifications_prefectures_on_prefecture_id    (prefecture_id)
#
# Foreign Keys
#
#  fk_rails_...  (notification_id => notifications.id)
#  fk_rails_...  (prefecture_id => prefectures.id)
#
class NotificationsPrefecture < ApplicationRecord
  acts_as_paranoid

  belongs_to :prefecture
  belongs_to :notification

  scope :by_prefecture_ids, lambda { |prefecture_ids|
    where(prefecture_id: prefecture_ids)
  }
end

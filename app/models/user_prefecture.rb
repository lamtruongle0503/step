# == Schema Information
#
# Table name: user_prefectures
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  prefecture_id :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_user_prefectures_on_prefecture_id  (prefecture_id)
#  index_user_prefectures_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (prefecture_id => prefectures.id)
#  fk_rails_...  (user_id => users.id)
#
class UserPrefecture < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture
end

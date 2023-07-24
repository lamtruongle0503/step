# == Schema Information
#
# Table name: life_support_prefectures
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  life_support_id :bigint
#  prefecture_id   :bigint
#
# Indexes
#
#  index_life_support_prefectures_on_life_support_id  (life_support_id)
#  index_life_support_prefectures_on_prefecture_id    (prefecture_id)
#
# Foreign Keys
#
#  fk_rails_...  (life_support_id => life_supports.id)
#  fk_rails_...  (prefecture_id => prefectures.id)
#
class LifeSupportPrefecture < ApplicationRecord
  belongs_to :life_support
  belongs_to :prefecture
end

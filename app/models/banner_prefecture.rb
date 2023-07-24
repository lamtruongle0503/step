# == Schema Information
#
# Table name: banner_prefectures
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  banner_id     :bigint
#  prefecture_id :bigint
#
# Indexes
#
#  index_banner_prefectures_on_banner_id      (banner_id)
#  index_banner_prefectures_on_prefecture_id  (prefecture_id)
#
# Foreign Keys
#
#  fk_rails_...  (banner_id => banners.id)
#  fk_rails_...  (prefecture_id => prefectures.id)
#
class BannerPrefecture < ApplicationRecord
  belongs_to :banner
  belongs_to :prefecture
end

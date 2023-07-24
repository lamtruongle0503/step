# == Schema Information
#
# Table name: news
#
#  id               :bigint           not null, primary key
#  author           :string
#  content          :text
#  deleted_at       :datetime
#  description      :text
#  name             :string
#  published_at     :datetime
#  title            :string
#  url              :string
#  url_to_image     :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  news_category_id :bigint
#
# Indexes
#
#  index_news_on_news_category_id  (news_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (news_category_id => news_categories.id)
#
class NewsFeed < ApplicationRecord
  self.table_name = 'news'

  acts_as_paranoid

  belongs_to :news_category
end

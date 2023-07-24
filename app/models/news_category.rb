# == Schema Information
#
# Table name: news_categories
#
#  id         :bigint           not null, primary key
#  code       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class NewsCategory < ApplicationRecord
  has_many :news_feeds, dependent: :destroy
end

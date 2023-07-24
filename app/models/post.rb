# == Schema Information
#
# Table name: posts
#
#  id                :bigint           not null, primary key
#  background_color  :string
#  contents          :string
#  like_count        :integer          default(0)
#  location          :string
#  status            :integer          default("no_approved")
#  type_post         :integer          default("open")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  diary_category_id :integer
#  user_id           :bigint           not null
#
# Indexes
#
#  index_posts_on_diary_category_id  (diary_category_id)
#  index_posts_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (diary_category_id => diary_categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :user
  belongs_to :diary_category, optional: true
  has_many :assets_modules, as: :module, dependent: :destroy
  has_many :assets, through: :assets_modules
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  PERSONAL = 'personal'.freeze
  OPEN = 'open'.freeze
  FOLLOW = 'follow'.freeze

  enum type_post: { personal: 0, open: 1, follow: 2 }
  enum status: { no_approved: 0, approved: 1, deny: 2 }

  scope :news_feeds, lambda { |user_id|
    joins('LEFT JOIN follows ON posts.user_id = follows.followed_id')
      .where("posts.user_id = #{user_id} OR follows.follower_id = #{user_id} AND posts.status = #{Post.statuses[:approved]}
        AND (posts.type_post!=0 AND follows.follower_id = #{user_id})")
  }

  scope :search_post, -> { where("posts.status = #{Post.statuses[:approved]}") }
  scope :user_posts, lambda { |is_follow|
    if is_follow
      where("posts.type_post IN (#{Post.type_posts[:open]}, #{Post.type_posts[:follow]}) AND posts.status = #{Post.statuses[:approved]}")
    else
      where("posts.type_post = #{Post.type_posts[:open]} AND posts.status = #{Post.statuses[:approved]}")
    end
  }
  ransacker :created_at, type: :date do
    Arel.sql "DATE(posts.created_at + interval '9 hour')"
  end
end

# == Schema Information
#
# Table name: comments
#
#  id           :bigint           not null, primary key
#  comment_type :string
#  contents     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  comment_id   :integer
#  post_id      :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_comments_on_comment_id  (comment_id)
#  index_comments_on_post_id     (post_id)
#  index_comments_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (comment_id => comments.id)
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :children, class_name: Comment.name, foreign_key: :comment_id, dependent: :destroy

  scope :parents, -> { where(comment_id: nil) }
end

# frozen_string_literal: true

class Api::DiaryOperations::PostOperations::SearchOperations::Index < ApplicationOperation
  def call
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).search_post
    search_posts(@posts, actor).newest.page(params[:page])
  end

  private

  def search_posts(posts, user)
    posts_ids = []
    posts.each do |obj|
      next if status_post_not_follow(obj) || user_is_blocked(actor, obj.user)

      if obj.type_post != Post::PERSONAL || (obj.user_id == user.id && obj.type_post == Post::PERSONAL)
        posts_ids.push(obj.id)
      end
    end
    Post.where(id: posts_ids).includes(:assets, :diary_category, user:     :asset,
                                                                 comments: [:children, { user: :asset }])
  end

  def status_post_not_follow(object)
    !actor.follows.pluck(:followed_id).include?(object.user.id) && object.type_post == Post::FOLLOW
  end
end

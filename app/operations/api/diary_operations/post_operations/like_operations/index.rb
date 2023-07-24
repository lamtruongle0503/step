# frozen_string_literal: true

class Api::DiaryOperations::PostOperations::LikeOperations::Index < ApplicationOperation
  attr_reader :post

  def initialize(actor, params)
    super
    @post = Post.find(params[:post_id])
  end

  def call
    likes = post.likes.includes(user: :asset).to_a
    sort_list_like(likes, actor)
  end

  private

  def sort_list_like(likes, actor)
    index = likes.index { |like| like.user_id == actor.id }
    return likes unless index

    likes.insert(0, likes.delete_at(index))
  end
end

# frozen_string_literal: true

class Api::DiaryOperations::PostOperations::LikeOperations::Destroy < ApplicationOperation
  attr_reader :post

  def initialize(actor, params)
    super
    @post = Post.find(params[:post_id])
  end

  def call
    ActiveRecord::Base.transaction do
      actor.likes.find_by!(post_id: post.id)&.destroy!
      post.decrement!(:like_count, 1)
    end
  end
end

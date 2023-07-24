# frozen_string_literal: true

class Api::DiaryOperations::PostOperations::CommentOperations::Index < ApplicationOperation
  attr_reader :post

  def initialize(actor, params)
    super
    @post = Post.find(params[:post_id])
  end

  def call
    post.comments.includes(children: [user: :asset], user: :asset).parents.newest.page(params[:page])
  end
end

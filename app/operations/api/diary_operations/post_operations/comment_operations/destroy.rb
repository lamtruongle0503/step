# frozen_string_literal: true

class Api::DiaryOperations::PostOperations::CommentOperations::Destroy < ApplicationOperation
  attr_reader :post

  def initialize(actor, params)
    super
    @post = Post.find(params[:post_id])
  end

  def call
    ActiveRecord::Base.transaction do
      post.comments.find(params[:id]).destroy!
    end
  end
end

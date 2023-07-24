# frozen_string_literal: true

class Api::DiaryOperations::PostOperations::CommentOperations::Create < ApplicationOperation
  attr_reader :post

  def initialize(actor, params)
    super
    @post = Post.find(params[:post_id])
  end

  def call
    ActiveRecord::Base.transaction do
      @comment = post.comments.create!(comment_params.merge!(user: actor))
    end
    @comment
  end

  private

  def comment_params
    params.permit(:contents, :comment_id, :comment_type)
  end
end

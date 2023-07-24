# frozen_string_literal: true

class Api::DiaryOperations::PostOperations::LikeOperations::Create < ApplicationOperation
  attr_reader :post

  def initialize(actor, params)
    super
    @post = Post.find(params[:post_id])
  end

  def call
    DiaryContracts::LikeContracts::Create.new(user_id: actor.id, post_id: params[:post_id]).valid!
    ActiveRecord::Base.transaction do
      actor.likes.create!(post: post)
      post.increment!(:like_count, 1)
    end
  end
end

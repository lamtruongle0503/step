# frozen_string_literal: true

class Admin::DiaryOperations::PostOperations::Destroy < ApplicationOperation
  def call
    post = Post.find(params[:id])
    ActiveRecord::Base.transaction do
      post.destroy!
    end
  end
end

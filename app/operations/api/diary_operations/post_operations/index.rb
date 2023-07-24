# frozen_string_literal: true

class Api::DiaryOperations::PostOperations::Index < ApplicationOperation
  attr_reader :user

  def initialize(actor, params)
    super
    @user = actor
  end

  def call
    Post.news_feeds(user.id).distinct
        .includes(:assets, :diary_category, user:     :asset,
                                            comments: [:children, { user: :asset }])
        .order(updated_at: :desc).page(params[:page])
  end
end

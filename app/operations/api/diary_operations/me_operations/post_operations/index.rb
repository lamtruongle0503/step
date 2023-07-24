# frozen_string_literal: true

class Api::DiaryOperations::MeOperations::PostOperations::Index < ApplicationOperation
  def call
    @posts = actor.posts.includes(:assets, :diary_category, user:     :asset,
                                                            comments: [:children, { user: :asset }])
                  .newest.page(params[:page])
  end
end

# frozen_string_literal: true

class Admin::DiaryOperations::PostOperations::Index < ApplicationOperation
  def call
    @q = Post.ransack(params[:q])
    @q.result.includes(:diary_category, :assets, [user: :asset]).order(updated_at: :desc).page(params[:page])
  end
end

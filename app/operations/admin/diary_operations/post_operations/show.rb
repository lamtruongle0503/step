# frozen_string_literal: true

class Admin::DiaryOperations::PostOperations::Show < ApplicationOperation
  def call
    Post.find(params[:id])
  end
end

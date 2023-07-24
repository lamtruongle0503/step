# frozen_string_literal: true

class Api::DiaryOperations::PostOperations::Show < ApplicationOperation
  def call
    @post = Post.find(params[:id])
  end
end

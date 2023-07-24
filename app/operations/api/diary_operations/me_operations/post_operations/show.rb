# frozen_string_literal: true

class Api::DiaryOperations::MeOperations::PostOperations::Show < ApplicationOperation
  def call
    @post = Post.find_by!(id: params[:id])
  end
end

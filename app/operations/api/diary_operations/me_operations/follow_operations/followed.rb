# frozen_string_literal: true

class Api::DiaryOperations::MeOperations::FollowOperations::Followed < ApplicationOperation
  def call
    @followed = Follow.user_followed(actor.id).includes(user_followed: :asset).newest.page(params[:page])
  end
end

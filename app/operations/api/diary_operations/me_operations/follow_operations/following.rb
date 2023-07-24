# frozen_string_literal: true

class Api::DiaryOperations::MeOperations::FollowOperations::Following < ApplicationOperation
  def call
    @following = actor.follows.includes(user_follower: :asset).newest.page(params[:page])
  end
end

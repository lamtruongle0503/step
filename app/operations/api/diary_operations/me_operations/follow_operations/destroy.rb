# frozen_string_literal: true

class Api::DiaryOperations::MeOperations::FollowOperations::Destroy < ApplicationOperation
  def call
    Follow.find_by!(followed_id: actor.id, follower_id: params[:id]).destroy!
  end
end

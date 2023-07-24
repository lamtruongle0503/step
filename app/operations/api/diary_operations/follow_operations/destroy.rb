# frozen_string_literal: true

class Api::DiaryOperations::FollowOperations::Destroy < ApplicationOperation
  def call
    actor.follows.find_by!(followed_id: params[:id]).destroy!
  end
end

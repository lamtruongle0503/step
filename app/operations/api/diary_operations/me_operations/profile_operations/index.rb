# frozen_string_literal: true

class Api::DiaryOperations::MeOperations::ProfileOperations::Index < ApplicationOperation
  def call
    post_number      = actor.posts.size
    follower_number  = actor.follows.size
    following_number = Follow.where(followed_id: actor.id).size

    { post_number: post_number, follower_number: follower_number, following_number: following_number,
user: actor }
  end
end

# frozen_string_literal: true

class Api::Diaries::Me::Profile::IndexSerializer < ApplicationSerializer
  attributes :post_number, :follower_number, :following_number, :user

  def post_number
    object[:post_number]
  end

  def follower_number
    object[:follower_number]
  end

  def following_number
    object[:following_number]
  end

  def user
    Api::Diaries::Users::MetaSerializer.new(object[:user]).as_json
  end
end

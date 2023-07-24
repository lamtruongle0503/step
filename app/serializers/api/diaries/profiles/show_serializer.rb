# frozen_string_literal: true

class Api::Diaries::Profiles::ShowSerializer < ApplicationSerializer
  attributes :post_number, :follower_number, :following_number, :is_blocked, :is_follow, :user, :is_blocker
  attr_reader :actor

  def initialize(object, options = {})
    super
    @actor = options[:actor]
  end

  def user
    Api::Diaries::Users::MetaSerializer.new(object).as_json
  end

  def post_number
    object.posts.user_posts(is_follow).size
  end

  def follower_number
    object.follows.size
  end

  def following_number
    object.followings.size
  end

  def is_blocker # rubocop:disable Naming/PredicateName
    object.user_blocks.map(&:blocked_id).include?(actor.id)
  end

  def is_blocked # rubocop:disable Naming/PredicateName
    actor.user_blocks.map(&:blocked_id).include?(object.id)
  end

  def is_follow # rubocop:disable Naming/PredicateName
    actor.follows.map(&:followed_id).include?(object.id)
  end
end

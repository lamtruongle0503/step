# frozen_string_literal: true

class Api::Diaries::Me::Posts::Comments::ChildrenSerializer < ApplicationSerializer
  attributes :id, :contents, :comment_type, :is_follow, :is_blocked, :is_blocked_by_owner, :user, :created_at

  def initialize(object, actor)
    super
    @actor = actor
    @object = object
  end

  def user
    Api::Diaries::Users::MetaSerializer.new(object.user).as_json
  end

  def is_follow # rubocop:disable Naming/PredicateName
    @actor.follows.pluck(:followed_id).include?(object.user_id)
  end

  def is_blocked # rubocop:disable Naming/PredicateName
    user_is_blocked(@actor, object.user)
  end

  def is_blocked_by_owner # rubocop:disable Naming/PredicateName
    user_is_blocked_by_owner(object.post.user, object.user)
  end
end

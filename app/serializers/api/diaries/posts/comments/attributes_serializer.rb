# frozen_string_literal: true

class Api::Diaries::Posts::Comments::AttributesSerializer < ApplicationSerializer
  attributes :id, :contents, :comment_type, :user, :created_at, :is_follow, :is_blocked, :is_blocked_by_owner

  def initialize(object, options = {})
    super
    @user = options[:actor]
  end

  def user
    Api::Diaries::Users::MetaSerializer.new(object.user).as_json
  end

  def is_follow # rubocop:disable Naming/PredicateName
    return unless @user

    @user.follows.pluck(:followed_id).include?(object.user_id)
  end

  def is_blocked # rubocop:disable Naming/PredicateName
    user_is_blocked(@user, object.user)
  end

  def is_blocked_by_owner # rubocop:disable Naming/PredicateName
    user_is_blocked_by_owner(object.post.user, object.user)
  end
end

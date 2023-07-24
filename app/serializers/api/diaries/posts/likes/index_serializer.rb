# frozen_string_literal: true

class Api::Diaries::Posts::Likes::IndexSerializer < ApplicationSerializer
  attributes :is_follow, :is_blocked, :is_blocked_by_owner
  belongs_to :user, serializer: Api::Diaries::Users::MetaSerializer

  attr_reader :actor

  def initialize(object, options = {})
    super
    @actor = options[:actor]
  end

  def is_follow # rubocop:disable Naming/PredicateName
    actor.follows.map(&:followed_id).include?(object.user.id)
  end

  def is_blocked # rubocop:disable Naming/PredicateName
    user_is_blocked(actor, object.user)
  end

  def is_blocked_by_owner # rubocop:disable Naming/PredicateName
    user_is_blocked_by_owner(object.post.user, object.user)
  end
end

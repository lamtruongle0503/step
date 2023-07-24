# frozen_string_literal: true

class Api::Diaries::Users::OtherUserSerializer < Api::Diaries::Users::MetaSerializer
  attributes :is_follow, :is_blocked
  attr_reader :actor

  def initialize(object, actor)
    super
    @actor = actor
  end

  def is_follow # rubocop:disable Naming/PredicateName
    actor.follows.map(&:followed_id).include?(object.id)
  end

  def is_blocked # rubocop:disable Naming/PredicateName
    actor.user_blocks.map(&:blocked_id).include?(object.id)
  end
end

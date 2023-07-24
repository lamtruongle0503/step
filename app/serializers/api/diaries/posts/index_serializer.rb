# frozen_string_literal: true

class Api::Diaries::Posts::IndexSerializer < Api::Diaries::Posts::AttributesSerializer
  attributes :is_follow, :is_like

  attr_reader :actor

  def initialize(object, options = {})
    super
    @actor = options[:actor]
  end

  def is_follow # rubocop:disable Naming/PredicateName
    actor.follows.pluck(:followed_id).include?(object.user.id)
  end

  def is_like # rubocop:disable Naming/PredicateName
    actor.likes.pluck(:post_id).include?(object.id)
  end
end

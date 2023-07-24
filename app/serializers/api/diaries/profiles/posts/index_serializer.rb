# frozen_string_literal: true

class Api::Diaries::Profiles::Posts::IndexSerializer < Api::Diaries::Profiles::Posts::AttributesSerializer
  attributes :is_like, :status, :is_follow

  def initialize(object, options = {})
    super
    @actor = options[:actor]
  end

  def is_like # rubocop:disable Naming/PredicateName
    @actor.likes.pluck(:post_id).include?(object.id)
  end

  def is_follow # rubocop:disable Naming/PredicateName
    @actor.follows.map(&:followed_id).include?(object.user_id)
  end
end

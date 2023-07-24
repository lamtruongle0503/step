# frozen_string_literal: true

class Api::Users::Searchs::IndexSerializer < Api::Users::IndexSerializer
  attributes :is_follow
  attr_reader :actor

  def initialize(object, options = {})
    super
    @actor = options[:actor]
  end

  def is_follow # rubocop:disable Naming/PredicateName
    actor.follows.pluck(:followed_id).include?(object.id)
  end
end

# frozen_string_literal: true

class Api::Diaries::Me::Posts::ShowSerializer < Api::Diaries::Me::Posts::AttributesSerializer
  attributes :is_like

  def initialize(object, options = {})
    super
    @actor = options[:actor]
  end

  def is_like # rubocop:disable Naming/PredicateName
    @actor.likes.pluck(:post_id).include?(object.id)
  end
end

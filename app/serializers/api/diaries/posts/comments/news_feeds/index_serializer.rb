# frozen_string_literal: true

module Api::Diaries::Posts::Comments::NewsFeeds
  class IndexSerializer < AttributesSerializer
    attributes :children

    def initialize(object, actor)
      super
      @user = actor
    end

    def children
      return [] if is_blocked || is_blocked_by_owner

      object.children.last(1).map do |comment|
        Api::Diaries::Posts::Comments::NewsFeeds::AttributesSerializer.new(comment, @user).as_json
      end
    end
  end
end

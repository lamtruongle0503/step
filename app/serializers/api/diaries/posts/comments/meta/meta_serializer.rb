# frozen_string_literal: true

module Api::Diaries::Posts::Comments::Meta
  class MetaSerializer < AttributesSerializer
    attributes :children

    def initialize(object, options = {})
      super
      @user = options[:actor]
    end

    def children
      return [] if is_blocked || is_blocked_by_owner

      object.children.map do |comment|
        Api::Diaries::Posts::Comments::Meta::AttributesSerializer.new(comment, @user).as_json
      end
    end
  end
end

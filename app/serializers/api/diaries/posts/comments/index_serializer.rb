# frozen_string_literal: true

module Api::Diaries::Posts::Comments
  class IndexSerializer < AttributesSerializer
    attributes :children

    def children
      object.children.last(1).map do |comment|
        Api::Diaries::Posts::Comments::AttributesSerializer.new(comment).as_json
      end
    end
  end
end

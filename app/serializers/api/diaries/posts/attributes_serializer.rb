# frozen_string_literal: true

class Api::Diaries::Posts::AttributesSerializer < ApplicationSerializer
  attributes :id, :contents, :like_count, :type_post, :comments, :location, :created_at
  belongs_to :user, serializer: Api::Diaries::Users::MetaSerializer
  has_many :assets, serializer: Assets::AttributesSerializer
  belongs_to :diary_category, serializer: Api::Diaries::Categories::Index

  def comments
    cmt = object.comments.parents.newest.detect do |comment|
      !(user_is_blocked(actor, comment.user) || user_is_blocked_by_owner(object.user, comment.user))
    end
    return [] unless cmt

    [Api::Diaries::Posts::Comments::NewsFeeds::IndexSerializer.new(cmt, actor).as_json]
  end
end

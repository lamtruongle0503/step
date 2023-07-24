# frozen_string_literal: true

class Api::Diaries::Profiles::Posts::AttributesSerializer < ApplicationSerializer
  attributes :id, :contents, :like_count, :type_post, :comments, :location, :created_at
  belongs_to :user, serializer: Api::Diaries::Users::MetaSerializer
  has_many :assets, serializer: Assets::AttributesSerializer
  belongs_to :diary_category, serializer: Api::Diaries::Categories::Index

  def comments
    object.comments.parents.last(1).map do |comment|
      Api::Diaries::Me::Posts::Comments::IndexSerializer.new(comment, @actor).as_json
    end
  end
end

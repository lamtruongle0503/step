# frozen_string_literal: true

class Admin::Diaries::Posts::AttributesSerializer < ApplicationSerializer
  attributes :id, :contents, :created_at, :type_post, :status
  belongs_to :user, serializer: Admin::Diaries::Users::MetaSerializer
  belongs_to :diary_category, serializer: Api::Diaries::Categories::Index
  has_many :assets, serializer: Assets::AttributesSerializer
end

# frozen_string_literal: true

class Api::Diaries::Me::Follows::FollowedSerializer < ApplicationSerializer
  attributes :user

  def user
    Api::Diaries::Users::MetaSerializer.new(object.user_followed)
  end
end

# frozen_string_literal: true

class Api::Diaries::Me::Follows::AttributesSerializer < ApplicationSerializer
  attributes :user

  def user
    Api::Diaries::Users::MetaSerializer.new(object.user_follower)
  end
end

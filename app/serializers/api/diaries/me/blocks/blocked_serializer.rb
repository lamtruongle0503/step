# frozen_string_literal: true

class Api::Diaries::Me::Blocks::BlockedSerializer < ApplicationSerializer
  attributes :user

  def user
    Api::Diaries::Users::MetaSerializer.new(object.user_blocked)
  end
end

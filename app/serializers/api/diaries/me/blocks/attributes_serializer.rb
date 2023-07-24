# frozen_string_literal: true

class Api::Diaries::Me::Blocks::AttributesSerializer < ApplicationSerializer
  attributes :user

  def user
    Api::Diaries::Users::MetaSerializer.new(object.user_blocker)
  end
end

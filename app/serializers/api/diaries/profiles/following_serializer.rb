# frozen_string_literal: true

class Api::Diaries::Profiles::FollowingSerializer < ApplicationSerializer
  attributes :user
  attr_reader :actor

  def initialize(object, options = {})
    super
    @actor = options[:actor]
  end

  def user
    Api::Diaries::Users::OtherUserSerializer.new(object.user_follower, actor)
  end
end

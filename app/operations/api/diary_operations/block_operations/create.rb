# frozen_string_literal: true

class Api::DiaryOperations::BlockOperations::Create < ApplicationOperation
  attr_reader :blocked, :user

  def initialize(actor, params)
    super
    @user = actor
    @blocked = User.find(params[:blocked_id])
  end

  def call
    DiaryContracts::BlockContracts::Create.new(record: user, blocked_id: blocked.id).valid!
    ActiveRecord::Base.transaction do
      actor.user_blocks.create!(blocked_id: blocked.id)
      unfollow
      user_unfollow
    end
  end

  def unfollow
    return unless actor.follows.map(&:followed_id).include?(blocked.id)

    actor.follows.find_by!(followed_id: blocked.id).destroy!
  end

  def user_unfollow
    return unless blocked.follows.map(&:followed_id).include?(actor.id)

    blocked.follows.find_by!(followed_id: actor.id).destroy!
  end
end

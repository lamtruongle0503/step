# frozen_string_literal: true

class Api::DiaryOperations::FollowOperations::Create < ApplicationOperation
  attr_reader :followed, :user

  def initialize(actor, params)
    super
    @user     = actor
    @followed = User.find(params[:followed_id])
  end

  def call
    DiaryContracts::FollowContracts::Create.new(record: user, followed_id: followed.id).valid!
    actor.follows.create!(followed_id: followed.id)
  end
end

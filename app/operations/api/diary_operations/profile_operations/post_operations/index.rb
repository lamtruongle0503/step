# frozen_string_literal: true

class Api::DiaryOperations::ProfileOperations::PostOperations::Index < ApplicationOperation
  attr_reader :user

  def initialize(actor, params)
    super
    @user = User.find(params[:profile_id])
  end

  def call
    user.posts.includes(:assets, :diary_category, user: :asset, comments: [:children, { user: :asset }])
        .user_posts(is_follow)
        .order(updated_at: :desc).page(params[:page])
  end

  private

  def is_follow # rubocop:disable Naming/PredicateName
    actor.follows.map(&:followed_id).include?(user.id)
  end
end

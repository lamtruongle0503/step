# frozen_string_literal: true

class Api::UserOperations::SearchOperations::Index < ApplicationOperation
  def call
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
    filter_users(@users, actor).includes(:asset).page(params[:page])
  end

  private

  def filter_users(users, actor)
    user_ids = []
    users.each do |user|
      next if user_is_blocked(actor, user)

      user_ids.push(user.id)
    end
    User.where(id: user_ids)
  end
end

# frozen_string_literal: true

class Api::DiaryOperations::ProfileOperations::Following < ApplicationOperation
  def call
    @user = User.find(params[:profile_id])
    @following = @user.follows.includes(user_follower: :asset).newest.to_a
    Kaminari.paginate_array(sort_list_following(@following, actor)).page(params[:page])
  end

  private

  def sort_list_following(list_following, actor)
    index = list_following.index { |following| following.followed_id == actor.id }
    return list_following unless index

    list_following.insert(0, list_following.delete_at(index))
  end
end

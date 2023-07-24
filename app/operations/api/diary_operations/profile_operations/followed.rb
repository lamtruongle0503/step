# frozen_string_literal: true

class Api::DiaryOperations::ProfileOperations::Followed < ApplicationOperation
  def call
    @user = User.find(params[:profile_id])
    @followed = Follow.user_followed(@user.id).includes(user_followed: :asset).newest.to_a
    Kaminari.paginate_array(sort_list_followed(@followed, actor)).page(params[:page])
  end

  private

  def sort_list_followed(list_followed, actor)
    index = list_followed.index { |followed| followed.follower_id == actor.id }
    return list_followed unless index

    list_followed.insert(0, list_followed.delete_at(index))
  end
end

# frozen_string_literal: true

module DiaryHelper
  def user_is_blocked(actor, user)
    actor.user_blocks.pluck(:blocked_id).include?(user&.id) ||
      user.user_blocks.pluck(:blocked_id).include?(actor&.id)
  end

  def user_is_blocked_by_owner(owner, user)
    user_is_blocked(owner, user)
  end
end

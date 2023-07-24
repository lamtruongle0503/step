# frozen_string_literal: true

class DiaryContracts::LikeContracts::Create < DiaryContracts::LikeContracts::Base
  validate :user_liked

  def user_liked
    return unless User.find(user_id).likes.pluck(:post_id).include?(post_id)

    errors.add :post_id, I18n.t('diaries.has_been_liked')
  end
end

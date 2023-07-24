# frozen_string_literal: true

class DiaryContracts::FollowContracts::Create < DiaryContracts::FollowContracts::Base
  attribute :record, User

  validate :users_followed

  def users_followed
    return unless record.follows.exists?(followed_id: followed_id)

    errors.add :followed_id, I18n.t('diaries.has_been_followed')
  end
end

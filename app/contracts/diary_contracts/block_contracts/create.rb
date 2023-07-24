# frozen_string_literal: true

class DiaryContracts::BlockContracts::Create < DiaryContracts::BlockContracts::Base
  attribute :record, User

  validate :users_blocked

  def users_blocked
    return unless record.user_blocks.exists?(blocked_id: blocked_id)

    errors.add :blocked_id, I18n.t('diaries.has_been_blocked')
  end
end

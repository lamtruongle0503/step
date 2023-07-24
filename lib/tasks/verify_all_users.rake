# frozen_string_literal: true

namespace :db do
  task verify_all_users: :environment do
    ActiveRecord::Base.transaction do
      update_is_verify_users
    end
  end

  private

  def update_is_verify_users
    User.all.each do |user|
      user.update!(
        verify_code: nil,
        expired_at:  nil,
        is_verify:   true,
      )
    end
  end
end

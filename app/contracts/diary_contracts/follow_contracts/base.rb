# frozen_string_literal: true

class DiaryContracts::FollowContracts::Base < ApplicationContract
  attribute :followed_id, Integer

  validates :followed_id, presence: true, existence: User.name
end

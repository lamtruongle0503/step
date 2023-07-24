# frozen_string_literal: true

class DiaryContracts::BlockContracts::Base < ApplicationContract
  attribute :blocked_id, Integer

  validates :blocked_id, presence: true, existence: User.name
end

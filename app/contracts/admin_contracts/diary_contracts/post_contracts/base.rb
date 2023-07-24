# frozen_string_literal: true

class AdminContracts::DiaryContracts::PostContracts::Base < ApplicationContract
  attribute :status, String

  validates :status, presence: true, inclusion: { in: Post.statuses }
end

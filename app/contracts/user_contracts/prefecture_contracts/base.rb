# frozen_string_literal: true

class UserContracts::PrefectureContracts::Base < ApplicationContract
  attribute :prefecture_id, Integer

  validates :prefecture_id, presence: true, existence: Prefecture.name
end

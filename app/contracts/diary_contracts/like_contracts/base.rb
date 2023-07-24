# frozen_string_literal: true

class DiaryContracts::LikeContracts::Base < ApplicationContract
  attribute :user_id,           Integer
  attribute :post_id,           Integer
end

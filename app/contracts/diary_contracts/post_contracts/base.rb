# frozen_string_literal: true

class DiaryContracts::PostContracts::Base < ApplicationContract
  attribute :user_id,           Integer
  attribute :diary_category_id, Integer
  attribute :contents,          String
  attribute :like_count,        Integer
  attribute :background_color,  String
  attribute :type_post,         String
  attribute :location,          String
end

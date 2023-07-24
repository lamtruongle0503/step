# frozen_string_literal: true

class Api::DiaryOperations::DiaryCategoryOperations::Index < ApplicationOperation
  def call
    @categories = DiaryCategory.all.order(:index)
  end
end

# frozen_string_literal: true

class DiaryContracts::PostContracts::Create < DiaryContracts::PostContracts::Base
  validates :type_post, inclusion: { in: Post.type_posts }
  validates :diary_category_id, existence: DiaryCategory.name, if: -> { diary_category_id.present? }
end

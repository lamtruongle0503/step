# frozen_string_literal: true

class DiaryContracts::ProfileContracts::Update < DiaryContracts::ProfileContracts::Base
  validates :nick_name, uniqueness: { model: User }, if: -> { nick_name.present? }
end

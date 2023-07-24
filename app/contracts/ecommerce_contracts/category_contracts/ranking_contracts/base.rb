# frozen_string_literal: true

class EcommerceContracts::CategoryContracts::RankingContracts::Base < ApplicationContract
  attribute :category_attributes, Array

  validates :category_attributes, presence: true

  validate :ranking_uniqueness

  def ranking_uniqueness
    return if category_attributes.pluck('ranking').uniq?

    errors.add :ranking, I18n.t('categories.ranking_must_unique')
  end
end
